defmodule PoCWeb.InitFingerPrintView do
  use PoCWeb, :view

  def render("index.json", permanent_token) do
    %{data: render_one(permanent_token, PoCWeb.InitFingerPrintView, "init.json")}
  end

  def render("init.json", _otekn) do
    %{finger_token: "finger_token"}
  end
end
