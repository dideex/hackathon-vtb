
defmodule PoCWeb.MakePaymentView do
  use PoCWeb, :view

  def render("index.json", permanent_token) do
    %{data: render_one(permanent_token, PoCWeb.MakePaymentView, "init.json")}
  end

  def render("init.json", _args) do
    %{result: "ok"}
  end
end
