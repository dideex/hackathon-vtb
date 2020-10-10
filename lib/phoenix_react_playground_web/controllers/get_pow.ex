defmodule PoCWeb.GetPoW do
  alias PoC.Redis
  alias PoC.Utils

  use PoCWeb, :controller

  def index(conn, _token) do
    [permanent_token] = get_req_header(conn, "permanent-token")

    with {:ok, hash, average_time, nonce} <- Utils.get_pow_hash() do
      now = DateTime.utc_now() |> DateTime.to_unix()
      Redis.put("pow_hash:#{permanent_token}", {average_time, nonce, now})
      render(conn, "index.json", hash: hash)
    else
      _ -> render(conn, "index.json", [])
    end

  rescue
    _ ->
      render(conn, "index.json", [])
  end
end
