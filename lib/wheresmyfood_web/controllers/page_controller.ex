defmodule WheresmyfoodWeb.PageController do
  use WheresmyfoodWeb, :controller

  alias Wheresmyfood.FoodTrucks.ApiClient

  def home(conn, _params) do
    case ApiClient.get_food_trucks_from_api() do
      data ->
        render(conn, "home.html", data: data)

      {:error, reason} ->
        conn
        |> put_flash(:error, "Error fetching data: #{reason}")
        |> render("error.html")
    end
  end
end
