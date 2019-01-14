defmodule CleanCode.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :status, :string
      add :customer_id, references(:customers, on_delete: :nothing)
      add :event_id, references(:events, on_delete: :nothing)

      timestamps()
    end

    create index(:orders, [:event_id])
    create index(:orders, [:customer_id])
  end
end
