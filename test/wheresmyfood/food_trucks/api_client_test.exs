defmodule Wheresmyfood.FoodTrucks.ApiClientTest do
  use ExUnit.Case, async: true

  import Mox

  alias HTTPoison.Error
  alias HTTPoison.Response
  alias HTTPoisonMock
  alias Wheresmyfood.FoodTrucks.ApiClient

  setup :verify_on_exit!

  @endpoint "https://data.sfgov.org/resource/rqzj-sfat.json"

  test "returns food trucks on successful response" do
    body = ~s([{"applicant": "Truck 1"}, {"applicant": "Truck 2"}])

    expect(HTTPoison.BaseMock, :get, fn @endpoint ->
      {:ok, %Response{status_code: 200, body: body}}
    end)

    assert {:ok, [%{"applicant" => "Truck 1"}, %{"applicant" => "Truck 2"}]} =
             ApiClient.get_food_trucks_from_api()
  end

  test "returns error on non-200 response" do
    expect(HTTPoison.BaseMock, :get, fn @endpoint ->
      {:ok, %Response{status_code: 404, body: ""}}
    end)

    assert {:error, "Received non-200 response: 404"} = ApiClient.get_food_trucks_from_api()
  end

  test "returns error on HTTP request failure" do
    expect(HTTPoison.BaseMock, :get, fn @endpoint ->
      {:error, %Error{reason: :timeout}}
    end)

    assert {:error, "HTTP request failed: :timeout"} = ApiClient.get_food_trucks_from_api()
  end

  test "returns error on JSON decode failure" do
    invalid_json = "invalid json"

    expect(HTTPoison.BaseMock, :get, fn @endpoint ->
      {:ok, %Response{status_code: 200, body: invalid_json}}
    end)

    assert {:error, "Failed to decode JSON response"} = ApiClient.get_food_trucks_from_api()
  end
end
