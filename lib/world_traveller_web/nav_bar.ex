defmodule WorldTravellerWeb.NavBar do
  use Phoenix.LiveComponent

  def render("app.html", assigns) do
    ~L"""
    <div>
      <a href="/visited" style="margin-right: 4px">Visited</a>
      <a href="/">Home</a>
    </div>
    """
  end
end
