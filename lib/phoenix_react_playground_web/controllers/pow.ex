defmodule PoCWeb.PoW do
  alias PoC.Redis
  alias PoC.Utils

  use PoCWeb, :controller

  def index(conn, %{"nonce" => nonce}) do
    nonce = String.to_integer(nonce)
    [permanent_token] = get_req_header(conn, "permanent-token")

    with {:ok, {average_time, ^nonce, timestamp}} <- Redis.get("pow_hash:#{permanent_token}") |> IO.inspect(label: :redis),
         {:ok, date_time} <- timestamp |> DateTime.from_unix(:millisecond) |> IO.inspect(label: :date) do
      diff = DateTime.utc_now() |> DateTime.diff(date_time)
      Utils.update_trust(permanent_token, :pow, average_time - diff)
      # TODO: del redis key
      render(conn, "index.json", res: :ok)
    else
      _ ->
        render(conn, "index.json", [])
    end
  # rescue
  #   _ ->
  #     render(conn, "index.json", [])
  end
end
