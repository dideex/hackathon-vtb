
defmodule PoCWeb.StateView do
  use PoCWeb, :view

  def render("index.json", %{state: state}) do
    %{data: render_one(state, PoCWeb.StateView, "init.json")}
  end

  def render("init.json", %{state: result}) do
    result
  end
end
