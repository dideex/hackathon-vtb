defmodule PoCWeb.InitSessionController do
  alias PoC.Redis
  alias PoC.Utils

  use PoCWeb, :controller

  def index(conn, %{"token" => token}) do
    {:ok, time} = Redis.get(token)
    value =
      with {:ok, date_time} <- time |> String.to_integer() |> DateTime.from_unix(),
           {:res, number} <- {:res, DateTime.utc_now() |> DateTime.diff(date_time)} do
        number
      else
        _ -> 100
      end
      |> case do
        number when number <= 2 -> 10
        number when number <= 4 -> 20
        number when number <= 8 -> 30
        number when number <= 16 -> 40
        _ -> 100
      end

    Redis.delete(token)
    permanent_token = Utils.rand_generate()
    Redis.put(permanent_token, %{hard_token: value})

    render(conn, "index.json", permanent_token: permanent_token)

    rescue
      _ ->
        render(conn, "index.json", [])
  end
end
