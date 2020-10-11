
defmodule PoCWeb.AuthView do
  use PoCWeb, :view

  def render("index.json", %{jwt: jwt}) do
    %{data: %{jwt: jwt}}
  end

  def render("index.json", _permanent_token) do
    %{error: "permission denied"}
  end
end
