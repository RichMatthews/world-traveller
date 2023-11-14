defmodule WorldTravellerWeb.Router do
  use WorldTravellerWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, html: {WorldTravellerWeb.Layouts, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  # scope "/api", WorldTravellerWeb do
  #   pipe_through :api
  #   get "/"
  # end

  scope "/", WorldTravellerWeb do
    pipe_through(:browser)

    live("/", HomeLive)
    live("/countries/:country", CountryLive)
    live("/visited", VisitedLive)

    # post("/search", CountryController, :get_country)
  end

  if Application.compile_env(:world_traveller, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through(:browser)

      live_dashboard("/dashboard", metrics: WorldTravellerWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
