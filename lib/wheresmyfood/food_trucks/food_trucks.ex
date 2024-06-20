defmodule Wheresmyfood.FoodTrucks do
  @moduledoc """
  Context module for managing food trucks data.
  """

  alias Wheresmyfood.FoodTrucks.ApiClient

  @spec list_food_trucks(module()) :: %{food_trucks: list()}
  def list_food_trucks(api_client \\ ApiClient) do
    with {:ok, food_trucks} <- api_client.get_food_trucks_from_api() do
      %{food_trucks: food_trucks}
    else
      _error -> %{food_trucks: []}
    end
  end

  @spec search_food_trucks(String.t(), module()) :: list()
  def search_food_trucks(query, api_client \\ ApiClient) do
    list_food_trucks(api_client)[:food_trucks]
    |> Enum.filter(fn truck ->
      String.contains?(String.downcase(truck["applicant"] || ""), String.downcase(query)) or
        String.contains?(String.downcase(truck["fooditems"] || ""), String.downcase(query))
    end)
  end
end
