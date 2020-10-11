defmodule PoCWeb.MakePayment do
  alias PoC.Utils
  alias PoC.WatchDog

  use PoCWeb, :controller

  def index(conn, %{"amount" => amount}) do
    [permanent_token] = get_req_header(conn, "permanent-token")
    WatchDog.increment(permanent_token)

    if Utils.trust?(permanent_token) do
      render(conn, "index.json", amount: amount)
    else
      render(conn, "index.json", [])
    end
  rescue
    _ ->
      render(conn, "index.json", [])
  end
end
