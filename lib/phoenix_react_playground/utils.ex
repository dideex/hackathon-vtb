defmodule PoC.Utils do
  alias PoC.Redis

  def trust?(token) do
    with {:ok, %{browser_token: c1, hard_token: c2, pow: c3}} <- Redis.get(token) |> IO.inspect(label: :token) do
      case pow_raing(c3) do
        6 when c1 <= 120 and c2 <= 40 -> true
        5 when c1 <= 100 and c2 <= 40 -> true
        4 when c1 <= 80  and c2 <= 30 -> true
        3 when c1 <= 60  and c2 <= 30 -> true
        2 when c1 <= 40  and c2 <= 20 -> true
        1 when c1 <= 20  and c2 <= 20 -> true
        0 when c1 <= 0   and c2 <= 10 -> true
        _ -> false
      end
      |> IO.inspect(label: :res)
    else
      _ -> false
    end
  end

  def get_pow_hash do
    # TODO: Add more cases
    with {:ok, {hash, average_time, nonce}} <- Redis.get("pow:#{Enum.random(1..1)}") do
      {:ok, hash, average_time, nonce}
    end
  end

  def update_trust(value, {permanent_token, key}),
    do: update_trust(permanent_token, key, value)

  def update_trust(permanent_token, key, value) do
    case Redis.get(permanent_token) do
      # {:ok, map} when key != :pow ->
      #   old = Map.get(map, key, 0)
      #   Redis.put(permanent_token, Map.put(map, key, old + value))

      {:ok, map} ->
        Redis.put(permanent_token, Map.put(map, key, value))

      {:error, :not_found} ->
        Redis.put(permanent_token, %{key => value})
    end
  end

  @spec rand_generate :: String.t()
  def rand_generate do
    24
    |> :crypto.strong_rand_bytes()
    |> Base.encode64()
    # remove the trailing =
    |> strip_trailing_char
  end

  @spec strip_trailing_char(string :: String.t()) :: String.t()
  def strip_trailing_char(string) do
    slen = byte_size(string) - 1
    <<core::binary-size(slen), _rest::binary>> = string
    core
  end

  #########################################################
  #
  #  Internal functions
  #
  #########################################################

  defp pow_raing(c) when c > 1000, do: 6
  defp pow_raing(c) when c > 500,  do: 5
  defp pow_raing(c) when c > 200,  do: 4
  defp pow_raing(c) when c > 0,    do: 3
  defp pow_raing(c) when c > -100, do: 2
  defp pow_raing(c) when c > -500, do: 1
  defp pow_raing(_),               do: 0
end
