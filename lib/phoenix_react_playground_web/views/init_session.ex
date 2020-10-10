defmodule PoCWeb.InitSessionView do
  use PoCWeb, :view

  def render("index.json", %{permanent_token: permanent_token}) do
    %{data: render_one(permanent_token, PoCWeb.InitSessionView, "init.json")}
  end

  def render("init.json", %{init_session: permanent_token}) do
    %{permanent_token: permanent_token}
  end
end
