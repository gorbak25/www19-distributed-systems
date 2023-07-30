defmodule Workshops.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    topologies = [
      local_epmd_example: [
        strategy: Elixir.Cluster.Strategy.LocalEpmd
      ]
    ]
    children = [
      ExampleGenServer,
      #{Cluster.Supervisor, [topologies, [name: Workshops.ClusterSupervisor]]},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Workshops.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
