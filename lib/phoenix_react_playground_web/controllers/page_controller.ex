defmodule PoCWeb.PageController do
  use PoCWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
