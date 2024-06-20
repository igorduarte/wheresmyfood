# mocks httpoison on tests
Mox.defmock(HTTPoison.BaseMock, for: HTTPoison.Base)
Application.put_env(:wheresmyfood, :http_client, HTTPoison.BaseMock)

Mox.defmock(Wheresmyfood.FoodTrucks.ApiClientMock,
  for: Wheresmyfood.FoodTrucks.ApiClientBehaviour
)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Wheresmyfood.Repo, :manual)
