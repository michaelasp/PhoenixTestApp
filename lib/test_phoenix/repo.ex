defmodule TestPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :test_phoenix,
    adapter: Ecto.Adapters.Postgres
end
