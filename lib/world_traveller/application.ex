defmodule WorldTraveller.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      WorldTravellerWeb.Telemetry,
      WorldTraveller.Repo,
      {DNSCluster, query: Application.get_env(:world_traveller, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: WorldTraveller.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: WorldTraveller.Finch},
      # Start a worker by calling: WorldTraveller.Worker.start_link(arg)
      # {WorldTraveller.Worker, arg},
      # Start to serve requests, typically the last entry
      WorldTravellerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WorldTraveller.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WorldTravellerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
