defmodule Wheresmyfood.FoodTrucks do
  @moduledoc """
  Context module for managing food trucks data.
  """

  alias Wheresmyfood.FoodTrucks.ApiClient

  @spec list_food_trucks() :: %{food_trucks: list()}
  def list_food_trucks() do
    case ApiClient.get_food_trucks_from_api() do
      {:ok, food_trucks} ->
        %{
          food_trucks: food_trucks
        }

      {:error, _reason} ->
        %{
          food_trucks: []
        }
    end
  end

  @spec search_food_trucks(String.t()) :: list()
  def search_food_trucks(query) do
    list_food_trucks()[:food_trucks]
    |> Enum.filter(fn truck ->
      String.contains?(String.downcase(truck["applicant"] || ""), String.downcase(query)) or
        String.contains?(String.downcase(truck["fooditems"] || ""), String.downcase(query))
    end)
  end
end
