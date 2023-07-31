defmodule Day3.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      Day3Web.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Day3.PubSub},
      # Start Finch
      {Finch, name: Day3.Finch},
      # Start the Endpoint (http/https)
      Day3Web.Endpoint,
      # Start a worker by calling: Day3.Worker.start_link(arg)
      # {Day3.Worker, arg}

      {Cluster.Supervisor, [Application.get_env(:libcluster, :topologies), [name: MyApp.ClusterSupervisor]]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Day3.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Day3Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
