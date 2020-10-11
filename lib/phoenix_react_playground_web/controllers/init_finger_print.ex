defmodule PoCWeb.InitFingerPrint do
  alias PoC.Redis
  alias PoC.Utils

  use PoCWeb, :controller

  def index(conn, %{"finger_print" => finger_print, "finger_token" => finger_token}) do
    [permanent_token] = get_req_header(conn, "permanent-token")
    {:ok, _token} = Redis.get(permanent_token)

    with {:ok, old_token} <- Redis.get("finger_print:#{finger_print}"),
         {:tokens, ^finger_token} <- {:tokens, old_token} do
      0
    else
      {:error, :not_found} ->
        20

      {:tokens, _token} ->
        50
    end
    |> Utils.update_trust({permanent_token, :browser_token})

    # TODO: del redis key
    finger_token = create_token(finger_print)
    render(conn, "index.json", finger_token: finger_token)
  rescue
    _ ->
      render(conn, "index.json", [])
  end

  defp create_token(finger_print) do
    finger_token = Utils.rand_generate()
    Redis.put("finger_print:#{finger_print}", finger_token)
    finger_token
  end
end
