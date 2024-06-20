defmodule Wheresmyfood.FoodTrucks.ApiClient do
  @moduledoc """
  Client module to fetch food truck data from the San Francisco open data API.
  """

  @behaviour Wheresmyfood.FoodTrucks.ApiClientBehaviour

  @endpoint "https://data.sfgov.org/resource/rqzj-sfat.json"

  alias HTTPoison.Response
  alias HTTPoison.Error

  require Logger

  @impl true
  @spec get_food_trucks_from_api() :: {:ok, list()} | {:error, String.t()}
  def get_food_trucks_from_api do
    case http_client().get(@endpoint) do
      {:ok, %Response{status_code: 200, body: body}} ->
        handle_response(body)

      {:ok, %Response{status_code: status_code}} ->
        handle_non_200_response(status_code)

      {:error, %Error{reason: reason}} ->
        handle_error_response(reason)
    end
  end

  @spec handle_response(String.t()) :: {:ok, list()} | {:error, String.t()}
  defp handle_response(body) do
    case Jason.decode(body) do
      {:ok, food_trucks} ->
        {:ok, food_trucks}

      {:error, error} ->
        Logger.error("Failed to decode JSON response: #{inspect(error)}")
        {:error, "Failed to decode JSON response"}
    end
  end

  @spec handle_non_200_response(integer()) :: {:error, String.t()}
  defp handle_non_200_response(status_code) do
    Logger.error("Received non-200 response: #{status_code}")
    {:error, "Received non-200 response: #{status_code}"}
  end

  @spec handle_error_response(any()) :: {:error, String.t()}
  defp handle_error_response(reason) do
    Logger.error("HTTP request failed: #{inspect(reason)}")
    {:error, "HTTP request failed: #{inspect(reason)}"}
  end

  defp http_client do
    Application.get_env(:wheresmyfood, :http_client)
  end
end
