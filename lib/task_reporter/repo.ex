defmodule TaskReporter.Repo do
  use Ecto.Repo,
    otp_app: :task_reporter,
    adapter: Ecto.Adapters.SQLite3
end
