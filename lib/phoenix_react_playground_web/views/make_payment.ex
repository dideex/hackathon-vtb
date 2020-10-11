
defmodule PoCWeb.MakePaymentView do
  use PoCWeb, :view

  def render("index.json", %{amount: amount}) do
    %{data: %{transfered: amount}}
  end

  def render("index.json", _args) do
    %{result: "permission denied"}
  end
end
