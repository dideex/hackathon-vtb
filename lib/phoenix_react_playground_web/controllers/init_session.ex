defmodule PoCWeb.InitSessionController do
  use PoCWeb, :controller

  def index(conn, _params) do
    render(conn, "index.json", trackers: %{})
  end
end
