defmodule PoCWeb.MeView do
  use PoCWeb, :view

  def render("index.json", permanent_token) do
    %{data: render_one(permanent_token, PoCWeb.MeView, "init.json")}
  end

  def render("init.json", _args) do
    %{user: %{user_id: "id"}}
  end
end
