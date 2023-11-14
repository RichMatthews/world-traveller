defmodule WorldTraveller.AuthController do
  def get_auth do
    api_key = "1bXCLAunik18i7Ovgf5ddvXnsNdazDrZ8zY1RYre"

    headers = %{
      "Authorization" => "Bearer #{api_key}"
    }

    %{headers: headers}
  end
end
