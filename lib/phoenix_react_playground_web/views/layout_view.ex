defmodule PoCWeb.LayoutView do
  use PoCWeb, :view

  alias PoC.Redis
  alias PoC.Utils

  def token do
    hash = Utils.rand_generate()
    Redis.put(hash, DateTime.utc_now() |> DateTime.to_unix() |> to_string())

    hash
  end
end
