
defmodule PoCWeb.GetPoWView do
  use PoCWeb, :view

  def render("index.json", permanent_token) do
    %{data: render_one(permanent_token, PoCWeb.GetPoWView, "init.json")}
  end

  def render("init.json", _args) do
    %{hash: "hash"}
  end
end
