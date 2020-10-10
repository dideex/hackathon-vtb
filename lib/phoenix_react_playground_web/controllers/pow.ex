
defmodule PoCWeb.PoW do
  alias PoC.Redis
  alias PoC.Utils

  use PoCWeb, :controller

  def index(conn, _token) do

    render(conn, "index.json", [])
  end
end
