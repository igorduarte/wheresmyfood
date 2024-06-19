defmodule WheresmyfoodWeb.FoodTrucksLive do
  use WheresmyfoodWeb, :live_view

  alias Wheresmyfood.FoodTrucks

  def mount(_params, _session, socket) do
    food_trucks = FoodTrucks.list_food_trucks()[:food_trucks]
    expanded_cards = %{}

    {:ok,
     assign(socket,
       food_trucks: food_trucks,
       query: "",
       expanded_cards: expanded_cards
     )}
  end

  def handle_event("search", %{"query" => query}, socket) do
    food_trucks = FoodTrucks.search_food_trucks(query)
    expanded_cards = %{}
    path = ~p"/?query=#{query}"

    {:noreply,
     push_patch(socket, food_trucks: food_trucks, expanded_cards: expanded_cards, to: path)}
  end

  def handle_event("toggle_expand", %{"index" => index}, socket) do
    index = String.to_integer(index)
    expanded_cards = Map.update(socket.assigns.expanded_cards, index, true, &(!&1))

    {:noreply, assign(socket, expanded_cards: expanded_cards)}
  end

  def handle_params(params, _url, socket) do
    query = Map.get(params, "query", "")

    {:noreply,
     assign(socket,
       query: query,
       food_trucks: FoodTrucks.search_food_trucks(query)
     )}
  end
end
