defmodule WorldTraveller.VisitedCountryContext do
  import Ecto.Query, warn: false
  alias WorldTraveller.Repo
  alias WorldTraveller.VisitedCountry

  def all_countries do
    Repo.all(VisitedCountry)
  end
end
