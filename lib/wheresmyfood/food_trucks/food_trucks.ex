defmodule Wheresmyfood.FoodTrucks do
  alias Wheresmyfood.FoodTrucks.ApiClient

  def list_food_trucks(params) do
    page = Map.get(params, "page", 1)
    search = Map.get(params, "search", "")

    food_trucks =
      ApiClient.get_food_trucks_from_api()
      |> filter_food_trucks(search)
      |> paginate_food_trucks(page, 15)

    total_count = length(food_trucks)

    %{
      food_trucks: food_trucks,
      total_count: total_count,
      total_pages: div(total_count + 15 - 1, 15)
    }
  end

  defp filter_food_trucks(food_trucks, search) do
    Enum.filter(food_trucks, fn truck ->
      String.contains?(truck["applicant"] || "", search) or
        String.contains?(truck["fooditems"] || "", search)
    end)
  end

  defp paginate_food_trucks(food_trucks, page, page_size) do
    food_trucks
    |> Enum.chunk_every(page_size)
    |> Enum.at(page - 1, [])
  end
end
