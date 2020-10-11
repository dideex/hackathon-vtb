defmodule PoCWeb.Me do
  # alias PoC.Redis
  alias PoC.Utils

  use PoCWeb, :controller

  def index(conn, _token) do
    [permanent_token] = get_req_header(conn, "permanent-token")

    if Utils.trust?(permanent_token) do
      render(conn, "index.json", user: %{user_id: "id", token: "jwt_token"})
    else
      render(conn, "index.json", [])
    end
  rescue
    _ ->
      render(conn, "index.json", [])
  end
end
