defmodule WheresmyfoodWeb.FoodTrucksController do
  use WheresmyfoodWeb, :controller

  alias Wheresmyfood.FoodTrucks

  def index(conn, %{"query" => query}) do
    food_trucks = FoodTrucks.search_food_trucks(query)
    render(conn, "index.html", food_trucks: food_trucks, query: query)
  end

  def index(conn, _params) do
    query = ""
    food_trucks = FoodTrucks.list_food_trucks()[:food_trucks]
    render(conn, "index.html", food_trucks: food_trucks, query: query)
  end
end
