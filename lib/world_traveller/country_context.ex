defmodule WorldTraveller.CountryContext do
  import Ecto.Query, warn: false
  alias WorldTraveller.AuthController
  alias WorldTraveller.Repo
  alias WorldTraveller.VisitedCountry

  def add_country(country) do
    IO.inspect("called.....?")
    changeset = VisitedCountry.changeset(%VisitedCountry{}, %{name: "Brazil"})

    case Repo.insert(changeset) do
      {:ok, _} ->
        IO.puts("Successfully inserted into visited_countries")

      {:error, changeset} ->
        IO.inspect(changeset.errors, label: "Failed to insert into visited_countries")
    end
  end

  def render_country(country) do
    response = get_country(country)

    %{
      capital: response["capital"] |> List.first(),
      flag: response["flags"]["svg"],
      name: country,
      population: response["population"],
      region: response["region"],
      visited: false
    }
  end

  def get_country(country) do
    auth = AuthController.get_auth()

    [first_word | _rest] = String.split(country, " ")
    countries = fetch_country(first_word)

    if length(countries) === 1 do
      Enum.at(countries, 0)
    else
      Enum.find(countries, fn ctry ->
        String.downcase(ctry["name"]["common"]) == String.downcase(country)
      end)
    end
  end

  def fetch_country(country) do
    auth = AuthController.get_auth()
    %{headers: headers} = auth

    case Req.get("https://restcountries.com/v3.1/name/#{country}",
           headers: headers,
           connect_options: [timeout: 70000]
         ) do
      {:ok, response} when response.status == 200 ->
        response.body

      {:ok, response} ->
        response

      {:error, reason} ->
        reason
    end
  end
end
