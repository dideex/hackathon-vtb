defmodule PoCWeb.Remove do
  alias PoC.Redis

  use PoCWeb, :controller

  def index(conn, _token) do
    [permanent_token] = get_req_header(conn, "permanent-token")
    Redis.delete(permanent_token)

    render(conn, "index.json", [])
  rescue
    _ ->
      render(conn, "index.json", [])
  end
end
