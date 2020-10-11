
defmodule PoCWeb.GetPoWView do
  use PoCWeb, :view

  def render("index.json", %{hash: hash}) do
    %{data: %{hash: hash}}
  end

  def render("index.json", _args) do
    %{error: "permission denied"}
  end
end
