defmodule PoCWeb.MeView do
  use PoCWeb, :view

  def render("index.json", %{user: user}) do
    %{data: user}
  end

  def render("index.json", _args) do
    %{error: "access deined"}
  end
end
