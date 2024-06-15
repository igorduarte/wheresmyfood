defmodule Wheresmyfood.FoodTrucks.ApiClient do
  @endpoint "https://data.sfgov.org/resource/rqzj-sfat.json"

  def get_food_trucks_from_api do
    case HTTPoison.get(@endpoint) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, food_trucks} = Jason.decode(body)
        food_trucks

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.puts("Error: #{reason}")
        []
    end
  end
end
