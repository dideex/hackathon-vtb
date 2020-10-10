defmodule PhoenixReactPlayground.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @redis_host Application.get_env(:phoenix_react_playground, :redis_host, "localhost")
  @redis_port Application.get_env(:phoenix_react_playground, :redis_port, 6379)

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      # PhoenixReactPlayground.Repo,
      # Start the Telemetry supervisor
      # PhoenixReactPlaygroundWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PhoenixReactPlayground.PubSub},
      # Redis
      {Redix, host: @redis_host, port: @redis_port, name: PhoenixReactPlayground.App.Redix},
      # Start the Endpoint (http/https)
      PhoenixReactPlaygroundWeb.Endpoint
      # Start a worker by calling: PhoenixReactPlayground.Worker.start_link(arg)
      # {PhoenixReactPlayground.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixReactPlayground.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PhoenixReactPlaygroundWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
