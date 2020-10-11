defmodule PoCWeb.MakePayment do
  alias PoC.Utils
  alias PoC.WatchDog

  use PoCWeb, :controller

  def index(conn, _token) do
    [permanent_token] = get_req_header(conn, "permanent-token")
    WatchDog.increment(permanent_token)

    if Utils.trust?(permanent_token) do
      render(conn, "index.json", amount: 1_000)
    else
      render(conn, "index.json", [])
    end
  rescue
    _ ->
      render(conn, "index.json", [])
  end
end
