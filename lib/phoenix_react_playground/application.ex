defmodule PoC.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @redis_host Application.get_env(:poc, :redis_host, "localhost")
  @redis_port Application.get_env(:poc, :redis_port, 6379)

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      # PoC.Repo,
      # Start the Telemetry supervisor
      # PoCWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PoC.PubSub},
      # Redis
      {Redix, host: @redis_host, port: @redis_port, name: PoC.App.Redix},
      # Start the Endpoint (http/https)
      PoCWeb.Endpoint
      # Start a worker by calling: PoC.Worker.start_link(arg)
      # {PoC.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PoC.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PoCWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
