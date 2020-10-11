defmodule PoCWeb.InitFingerPrintView do
  use PoCWeb, :view

  def render("index.json", %{finger_token: finger_token}) do
    %{data: %{finger_token: finger_token}}
  end

  def render("index.json", _finger_token) do
    %{error: "permission denied"}
  end
end
