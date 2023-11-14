defmodule WorldTraveller.Repo do
  use Ecto.Repo,
    otp_app: :world_traveller,
    adapter: Ecto.Adapters.Postgres
end
