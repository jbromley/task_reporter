defmodule TaskReporterWeb.PageController do
  use TaskReporterWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
