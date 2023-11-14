defmodule WorldTraveller.VisitedFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `WorldTraveller.Visited` context.
  """

  @doc """
  Generate a country.
  """
  def country_fixture(attrs \\ %{}) do
    {:ok, country} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> WorldTraveller.Visited.create_country()

    country
  end
end
