defmodule PoCWeb.PoWView do
  use PoCWeb, :view

  def render("index.json", %{res: :ok}) do
    %{data: %{result: "ok"}}
  end

  def render("index.json", _) do
    %{error: "permission deined"}
  end
end
