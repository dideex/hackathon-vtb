defmodule PoCWeb.InitSessionView do
  use PoCWeb, :view

  def render("index.json", %{permanent_token: permanent_token}) do
    %{data: %{permanent_token: permanent_token}}
  end
end
