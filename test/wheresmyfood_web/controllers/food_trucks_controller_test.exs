defmodule WheresmyfoodWeb.FoodTrucksControllerTest do
  use WheresmyfoodWeb.ConnCase

  test "GET /food_trucks", %{conn: conn} do
    conn = get(conn, ~p"/food_trucks")
    assert html_response(conn, 200) =~ "Where's my food?"
  end
end
