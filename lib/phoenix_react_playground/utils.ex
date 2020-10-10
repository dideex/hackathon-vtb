defmodule PoC.Utils do
  alias PoC.Redis

  def get_pow_hash do
    with {:ok, {hash, average_time, nonce}} <- Redis.get("pow:#{Enum.random(1..2)}") do
      {:ok, hash, average_time, nonce}
    end
  end

  def update_trust(value, {permanent_token, key}),
    do: update_trust(permanent_token, key, value)

  def update_trust(permanent_token, key, value) do
    case Redis.get(permanent_token) do
      {:ok, map} ->
        old = Map.get(map, key, 0)
        Redis.put(permanent_token, Map.put(map, key, old + value))

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
end
