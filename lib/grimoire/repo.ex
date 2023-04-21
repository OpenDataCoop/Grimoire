defmodule Grimoire.Repo do
  use Ecto.Repo,
    otp_app: :grimoire,
    adapter: Ecto.Adapters.Postgres
end
