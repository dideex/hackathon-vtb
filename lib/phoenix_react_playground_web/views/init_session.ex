defmodule PhoenixReactPlaygroundWeb.InitSessionView do
  use PhoenixReactPlaygroundWeb, :view

  def render("index.json", %{trackers: trackers}) do
    %{data: render_one(trackers, PhoenixReactPlaygroundWeb.InitSessionView, "init.json")}
  end

  def render("init.json", _) do
    %{permanent_token: DateTime.utc_now()}
  end
end

post:init_session {token: <Token>} -> {pernament_token: <Token>}
post:init_fingerpring {fingerprint: <String>, finger_token: <String> | null} -> {finger_token: <String>}
# get:pow {} -> {hash: <String>}
# post:init_pow {hash: <String>} -> null

post:auth {login: <String>, password: <String>} -> {user_token: token} | error
get:me {} -> {user: <User>}
post:make_payment {amount: <Float>, phone: <String>} -> ok | error
