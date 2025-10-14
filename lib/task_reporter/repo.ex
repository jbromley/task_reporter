defmodule TaskReporter.Repo do
  use Ecto.Repo,
    otp_app: :task_reporter,
    adapter: Ecto.Adapters.Postgres
end
