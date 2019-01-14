defmodule CleanCode.Repo do
  use Ecto.Repo,
    otp_app: :clean_code,
    adapter: Ecto.Adapters.Postgres
end
