defmodule PoCWeb.RemoveView do
  use PoCWeb, :view

  def render("index.json", _) do
    %{data: %{result: "ok"}}
  end
end
