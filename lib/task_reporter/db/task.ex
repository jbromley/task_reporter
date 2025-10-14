defmodule TaskReporter.Db.Task do
  use Ecto.Schema

  @primary_key {:uuid, :string, []}
  schema "tasks" do
    field :data, :string
  end
end
