defmodule PoCWeb.InitSessionController do
  alias PoC.Redis
  alias PoC.Utils

  use PoCWeb, :controller

  def index(conn, %{"token" => token}) do
    value =
      with {:ok, time} <- Redis.get(token),
           {:ok, date_time} <- time |> String.to_integer() |> DateTime.from_unix(),
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

    permanent_token = Utils.rand_generate()
    Redis.put(permanent_token, %{hard_token: value})

    render(conn, "index.json", permanent_token: permanent_token)
  end
end
