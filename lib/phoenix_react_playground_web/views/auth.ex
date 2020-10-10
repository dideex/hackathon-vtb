
defmodule PoCWeb.AuthView do
  use PoCWeb, :view

  def render("index.json", permanent_token) do
    %{data: render_one(permanent_token, PoCWeb.AuthView, "init.json")}
  end

  def render("init.json", _permanent_token) do
    %{jwt_token: "jwt"}
  end
end
