defmodule PoCWeb.Router do
  use PoCWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]

    # TODO: add block for permanent token
    # post "/init", PoCWeb.InitSessionController, :index

    post "/init_session", PoCWeb.InitSessionController, :index
    post "/init_fingerpring", PoCWeb.InitFingerPrint, :index
    post "/pow", PoCWeb.PoW, :index
    post "/auth", PoCWeb.Auth, :index
    post "/make_payment", PoCWeb.MakePayment, :index

    get "/pow", PoCWeb.GetPoW, :index
    get "/me", PoCWeb.Me, :index

    # TODO: for debug
    get "/personal_state", PoCWeb.State, :show
  end

# post:init_session {token: <Token>} -> {pernament_token: <Token>}
# post:init_fingerprint {fingerprint: <String>, finger_token: <String> | null} -> {finger_token: <String>}
# # get:pow {} -> {hash: <String>}
# # post:pow {nonce: <Int>} -> null

# post:auth {login: <String>, password: <String>} -> {user_token: token} | error
# get:me {} -> {user: <User>}
# post:make_payment {amount: <Float>, phone: <String>} -> ok | error


  scope "/", PoCWeb do
    pipe_through :browser

    # get "/", PageController, :index
    get "/*path", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PoCWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
    end
  end
end
