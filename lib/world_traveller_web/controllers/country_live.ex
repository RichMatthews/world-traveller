defmodule WorldTravellerWeb.CountryLive do
  alias WorldTraveller.CountryContext

  use Phoenix.LiveView

  def render(assigns) do
    ~H"""
    <div>
    <div style="display: flex; flex-direction: row; justify-content: space-between; width: 750px">
    <div style="display: flex; flex-direction: column">
      <div style="display: flex; align-items: center">
        <div style="font-size: 32px; margin-right: 4px;"><%= String.capitalize(@country.name) %></div>
      </div>
      <%= if @country.visited do %>
        <div style="font-size: 12px; background: #439c65; color: #40ff89; padding: 4px">Visited</div>
      <% end %>
      <div>Capital: <%= @country.capital %></div>
      <div>Population: <%= @country.population %></div>
      <div>Continent: <%= @country.region %></div>
    </div>
      <img src={@country.flag} style="width: 250px" />
    </div>
      <button phx-click="click" phx-value="brazil"> Visited </button>
    </div>
    """
  end

  def mount(params, _session, socket) do
    country_name = Map.get(params, "country")
    country = CountryContext.render_country(country_name)
    {:ok, assign(socket, :country, country)}
  end

  def handle_event("click", %{"value" => value}, socket) do
    CountryContext.add_country("Brazil")
    {:noreply, assign(socket, :data, [])}
  end
end
