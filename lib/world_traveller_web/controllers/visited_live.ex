defmodule WorldTravellerWeb.VisitedLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~H"""
    <div>
      <h1 style="font-weight: bold">Visited Countries</h1>
      <%= for country <- @countries do %>
        <div>
          <a href={"/countries/" <> String.downcase(country.name)}><%= country.name %></a>
        </div>
      <% end %>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    countries = WorldTraveller.VisitedCountryContext.all_countries()
    {:ok, assign(socket, :countries, countries)}
  end
end
