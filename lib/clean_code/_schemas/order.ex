defmodule CleanCode.Order do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias CleanCode.Customer
  alias CleanCode.Event

  schema "orders" do
    field :status, :string
    belongs_to :customer, Customer
    belongs_to :event, Event

    timestamps()
  end

  def changeset(order, attrs) do
    order
    |> cast(attrs, [:status])
    |> ensure_customer(attrs)
    |> ensure_event(attrs)
    |> validate_required([:status])
  end

  defp ensure_customer(changeset, attrs) do
    changeset
    |> put_assoc(:customer, attrs.customer)
    |> assoc_constraint(:customer)
  end

  defp ensure_event(changeset, attrs) do
    changeset
    |> put_assoc(:event, attrs.event)
    |> assoc_constraint(:event)
  end
end
