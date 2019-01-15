defmodule CleanCode.Order do
  @moduledoc false
  use CleanCode.Schema
  alias CleanCode.Customer
  alias CleanCode.Event

  @type t :: %__MODULE__{
          id: integer(),
          status: String.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  @type order_attrs :: %{
          status: String.t(),
          customer: Schema.belongs_to(Customer.t()),
          event: Schema.belongs_to(Event.t())
        }

  schema "orders" do
    field :status, :string
    belongs_to :customer, Customer
    belongs_to :event, Event

    timestamps()
  end

  # @spec changeset(t, order_attrs) :: Ecto.Changeset.t()
  def changeset(order, order_attrs) do
    order
    |> cast(order_attrs, [:status])
    |> validate_customer(order_attrs)
    |> validate_event(order_attrs)
    |> validate_required([:status])
  end

  defp validate_customer(changeset, attrs) do
    changeset
    |> put_assoc(:customer, attrs.customer)
    |> assoc_constraint(:customer)
  end

  defp validate_event(changeset, attrs) do
    changeset
    |> put_assoc(:event, attrs.event)
    |> assoc_constraint(:event)
  end
end
