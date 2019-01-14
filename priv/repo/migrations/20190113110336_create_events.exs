defmodule CleanCode.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :title, :string
      add :published, :boolean, default: false, null: false
      add :description, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :start_at, :utc_datetime
      add :end_at, :utc_datetime

      timestamps()
    end

    create index(:events, [:user_id])
  end
end
