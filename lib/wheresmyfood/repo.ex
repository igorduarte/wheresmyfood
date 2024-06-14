defmodule Wheresmyfood.Repo do
  use Ecto.Repo,
    otp_app: :wheresmyfood,
    adapter: Ecto.Adapters.Postgres
end
