import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :wheresmyfood, Wheresmyfood.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "wheresmyfood_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :wheresmyfood, WheresmyfoodWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "R7Zkah2jQCVL4LRwgx4ulQ97VqARCcydjnS8sxLYoLA/LmnlKdwsq+66NDPqjqtZ",
  server: false

# In test we don't send emails.
config :wheresmyfood, Wheresmyfood.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :phoenix_live_view,
  # Enable helpful, but potentially expensive runtime checks
  enable_expensive_runtime_checks: true

# Mocks
config :wheresmyfood, http_client: HTTPoison.BaseMock
config :wheresmyfood, :api_client, Wheresmyfood.FoodTrucks.ApiClientMock
