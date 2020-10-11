defmodule PoCWeb.State do
  alias PoC.Redis
  alias PoC.Utils

  use PoCWeb, :controller

  import Plug.Conn

  def show(conn, _args) do
    with [token] <- get_req_header(conn, "permanent-token"),
         {:ok, state} <- Redis.get(token) do
      render(conn, "index.json", [state: state])
    else
      _ -> render(conn, "index.json", [])
    end
  end
end
