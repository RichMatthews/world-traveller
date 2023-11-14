defmodule WorldTraveller.Api do
  alias WorldTraveller.AuthController

  def get_countries do
    auth = AuthController.get_auth()
    %{headers: headers} = auth

    case Req.get("https://restcountries.com/v3.1/name/can",
           headers: headers,
           connect_options: [timeout: 70000]
         ) do
      {:ok, response} when response.status == 200 ->
        response.body

      # {:ok, response} ->
      #   text(conn, "Failed to fetch data")

      {:error, reason} ->
        nil
    end
  end
end
