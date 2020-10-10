defmodule PoC.Repo do
  use Ecto.Repo,
    otp_app: :poc,
    adapter: Ecto.Adapters.Postgres
end
