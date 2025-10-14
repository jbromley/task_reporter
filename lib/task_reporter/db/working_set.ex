defmodule TaskReporter.Db.WorkingSet do
  use Ecto.Schema

  schema "working_set" do
    field :uuid, :string
  end
end
