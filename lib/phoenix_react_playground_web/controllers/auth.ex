
defmodule PoCWeb.Auth do
  alias PoC.Utils
  alias PoC.WatchDog
  alias PoC.Redis

  use PoCWeb, :controller

  def index(conn, _token) do
    [permanent_token] = get_req_header(conn, "permanent-token")
    {:ok, _token} = Redis.get(permanent_token)
    WatchDog.increment(permanent_token)

    if Utils.trust?(permanent_token) do
      render(conn, "index.json", jwt: "jwt")
    else
      render(conn, "index.json", [])
    end
  rescue
    _ ->
      render(conn, "index.json", [])
  end
end
