defmodule Wheresmyfood.FoodTrucks.ApiClientBehaviour do
  @callback get_food_trucks_from_api() :: {:ok, list()} | {:error, String.t()}
end
