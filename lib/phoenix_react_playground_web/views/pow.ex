defmodule PoCWeb.PoWView do
  use PoCWeb, :view

  def render("index.json", args) do
    %{data: render_one(args, PoCWeb.PoWView, "init.json")}
  end

  def render("init.json", _) do
    %{result: "ok"}
  end
end
