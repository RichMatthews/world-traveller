defmodule WorldTravellerWeb.HomeLive do
  alias WorldTraveller.Api

  use Phoenix.LiveView
  @layout {WorldTravellerWeb.Layout, :app_layout}

  def render(assigns) do
    ~H"""

    <div style="padding: 8px;">
      <div> Countries </div>

      <button phx-click="click" style="border: 1px solid #ccc; padding: 4px;"> Show Countries </button>

      <%= for item <- @data do %>
        <div>
          <a href={"/countries/" <> String.downcase(item["name"])}>View <%= item["name"] %></a>
        </div>
      <% end %>
    </div>
    """
  end

  # function to make the String.downcase above replace " " with "_"
  # add in later <input phx-change="search"  />

  def handle_event("click", _, socket) do
    IO.inspect("clicked the button")

    case Api.get_countries() do
      data ->
        filtered_list =
          Enum.map(data, fn map ->
            %{
              "name" => Map.get(map, "name")["common"],
              "population" => Map.get(map, "population"),
              "flag" => Map.get(map, "flag")
            }
          end)

        IO.inspect(filtered_list)

        {:noreply, assign(socket, :data, filtered_list)}

      {:error, _reason} ->
        {:ok, assign(socket, :data, [])}
    end
  end

  def handle_event("search", paylod, socket) do
    {:noreply, socket}
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :data, [])}
  end
end
