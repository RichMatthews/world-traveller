defmodule WorldTraveller.VisitedCountry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "visited_countries" do
    field(:name, :string)

    timestamps(type: :utc_datetime)
  end

  def changeset(visited_country, attrs) do
    visited_country
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
