defmodule TaskReporter.Tasks do
  import Ecto.Query
  alias TaskReporter.Repo
  alias TaskReporter.Db.{Task, WorkingSet}

  def list_pending_tasks do
    query =
      from ws in WorkingSet,
      join: t in Task,
      on: ws.uuid == t.uuid,
      select: t.data

    Repo.all(query)
    |> Enum.map(&parse_task/1)
    |> Enum.sort_by(&task_sort_key/1)
  end

  defp parse_task(json) do
    {:ok, data} = Jason.decode(json)

    annotations =
      data
      |> Enum.filter(fn {k, _} -> String.starts_with?(k, "annotation_") end)
      |> Enum.map(fn {"annotation" <> ts, msg} ->
        ts = String.to_integer(ts)
        date = DateTime.from_unix!(ts) |> DateTime.to_date()
        "#{date} #{msg}"
      end)

      Map.merge(data, %{"annotations" => annotations})
  end

  defp task_sort_key(%{"priority" => p}) do
    case p do
      "H" -> 0
      "M" -> 1
      "L" -> 2
      _ -> 3
    end
  end
  defp task_sort_key(_), do: 3

end
