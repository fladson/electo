defmodule Electo.Repo do
  use Ecto.Repo,
    otp_app: :electo,
    adapter: Ecto.Adapters.Postgres
end
