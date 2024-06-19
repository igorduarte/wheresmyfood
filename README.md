# Wheresmyfood?

["Where's My Food?"](https://wheresmyfood.gigalixirapp.com/) is a Phoenix-based web application that helps users find food trucks in San Francisco. The application fetches food truck data from the [San Francisco open data API](https://data.sfgov.org/resource/rqzj-sfat.json) and displays it in an interactive and user-friendly interface that allows you to search and find the best match between what kind of food you are looking for.

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Future Improvements](#future-improvements)

## Features
- **Search Functionality:** Users can search for food trucks by name or food items.
- **Dynamic Filtering:** The list of food trucks is dynamically filtered as the user types in the search field.
- **Responsive UI:** The application features a responsive design that works on both desktop and mobile devices.
- **Detailed Food Truck Information:** Users can view detailed information about each food truck, including location, operating hours, and food items.
- **Interactive Maps:** Embedded Google Maps are available for viewing the exact location of each food truck.

## Installation

### Prerequisites
- Elixir and Phoenix installed on your machine
- PostgreSQL database

### Steps

To start your Phoenix server:
  * Run `cp .env.sample .env` and add the proper environment values to `.env`
  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
  * Open your browser and navigate to http://localhost:4000.

## Usage
### Fetch Food Truck Data:
The application fetches data from the San Francisco open data API. Make sure you have an internet connection.

### Searching for Food Trucks:

Use the search bar at the top of the page to search for food trucks by name or food items.
The list of food trucks will be dynamically filtered as you type.

The dynamic filtering and search functionality is implemented using Phoenix LiveView. But theres also a resource called [/food_trucks](https://wheresmyfood.gigalixirapp.com/food_trucks) that you can access that's not using LiveView, so you can search by typing your desired food and hitting ENTER instead of waiting for the dynamic loading of the food trucks while you're typing.

## Future Improvements

* Develop a caching strategy (maybe using ETS) to not make a request everytime to the API and avoid problems when the API is down.
* User Authentication: Add user authentication to allow users to save favorite food trucks and submit reviews.
* Advanced Search Filters: Add filters for searching by location, rating, and cuisine type.


