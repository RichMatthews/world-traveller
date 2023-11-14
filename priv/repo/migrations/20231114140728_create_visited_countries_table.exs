defmodule WorldTraveller.Repo.Migrations.CreateVisitedCountries do
  use Ecto.Migration

  def change do
    create table(:visited_countries) do
      add(:name, :string)
      timestamps()
    end
  end
end
