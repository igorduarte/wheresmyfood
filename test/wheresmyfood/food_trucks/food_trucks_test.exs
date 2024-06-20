defmodule Wheresmyfood.FoodTrucksTest do
  use ExUnit.Case, async: true

  import Mox

  alias Wheresmyfood.FoodTrucks
  alias Wheresmyfood.FoodTrucks.ApiClientMock

  setup :verify_on_exit!

  describe "list_food_trucks/0" do
    test "returns a list of food trucks on successful API response" do
      expect(ApiClientMock, :get_food_trucks_from_api, fn ->
        {:ok, [%{"applicant" => "Truck 1"}, %{"applicant" => "Truck 2"}]}
      end)

      result = FoodTrucks.list_food_trucks(ApiClientMock)
      assert result == %{food_trucks: [%{"applicant" => "Truck 1"}, %{"applicant" => "Truck 2"}]}
    end

    test "returns an empty list on API error" do
      expect(ApiClientMock, :get_food_trucks_from_api, fn ->
        {:error, "Some error"}
      end)

      result = FoodTrucks.list_food_trucks(ApiClientMock)
      assert result == %{food_trucks: []}
    end
  end

  describe "search_food_trucks/1" do
    setup do
      expect(ApiClientMock, :get_food_trucks_from_api, fn ->
        {:ok,
         [
           %{"applicant" => "Truck 1", "fooditems" => "Pizza"},
           %{"applicant" => "Truck 2", "fooditems" => "Burgers"},
           %{"applicant" => "Truck 3", "fooditems" => "Tacos"}
         ]}
      end)

      :ok
    end

    test "returns trucks matching the query in applicant" do
      result = FoodTrucks.search_food_trucks("Truck 1", ApiClientMock)
      assert result == [%{"applicant" => "Truck 1", "fooditems" => "Pizza"}]
    end

    test "returns trucks matching the query in fooditems" do
      result = FoodTrucks.search_food_trucks("Burgers", ApiClientMock)
      assert result == [%{"applicant" => "Truck 2", "fooditems" => "Burgers"}]
    end

    test "returns trucks matching the query case insensitively" do
      result = FoodTrucks.search_food_trucks("tacos", ApiClientMock)
      assert result == [%{"applicant" => "Truck 3", "fooditems" => "Tacos"}]
    end

    test "returns an empty list if no match is found" do
      result = FoodTrucks.search_food_trucks("Sushi", ApiClientMock)
      assert result == []
    end
  end
end
