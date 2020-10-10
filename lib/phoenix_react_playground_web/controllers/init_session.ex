defmodule PhoenixReactPlaygroundWeb.InitSessionController do
  use PhoenixReactPlaygroundWeb, :controller

  def index(conn, _params) do
    render(conn, "index.json", trackers: %{})
  end
end
