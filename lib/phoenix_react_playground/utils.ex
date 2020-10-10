
defmodule PoC.Utils do

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
