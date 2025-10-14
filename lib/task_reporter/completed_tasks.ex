defmodule TaskReporter.CompletedTasks do
  import Ecto.Query
  alias TaskReporter.Repo
  alias TaskReporter.Tasks.Task

  def list_completed_tasks do
    from(t in Task, select: t.data)
    |> Repo.all()
    |> Enum.map(&parse_task/1)
    |> Enum.filter(&(&1["status"] == "completed"))
    |> Enum.sort_by(&sort_key/1, :desc)
  end

  defp parse_task(json) do
    {:ok, data} = Jason.decode(json)
    data
  end

  defp sort_key(task) do
    task["end"] |> String.to_integer()
  end
end
