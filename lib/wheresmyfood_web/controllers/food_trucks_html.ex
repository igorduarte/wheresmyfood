defmodule WheresmyfoodWeb.FoodTrucksHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use WheresmyfoodWeb, :html

  embed_templates "food_trucks_html/*"
end
