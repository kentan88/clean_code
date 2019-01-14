defmodule CleanCode.Customer do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias CleanCode.Order

  schema "customers" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :mobile_no, :string

    has_many :orders, Order
    timestamps()
  end

  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:first_name, :last_name, :email, :mobile_no])
    |> validate_required([:first_name, :last_name, :email, :mobile_no])
  end
end
