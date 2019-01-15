defmodule CleanCode.Customer do
  @moduledoc false
  use CleanCode.Schema
  alias CleanCode.Customer
  alias CleanCode.Order

  @type t :: %__MODULE__{
          id: integer(),
          email: String.t(),
          first_name: String.t(),
          last_name: String.t(),
          mobile_no: String.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

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

# defmodule CleanCode.Sales.Customer do
#   @moduledoc """
#   wip
#   """
#   alias CleanCode.Customer
#   alias CleanCode.Repo
#   import CleanCode.CustomerQuery #, only: [duplicate: 2]
#
#   def list_customers(query \\ Customer) do
#     Repo.all(query)
#   end
#
#   def customers_with_at_least_paid_orders(count) do
#     Customer
#     |> with_at_least_paid_orders(count)
#     |> list_customers()
#   end
#
#   def customers_with_failed_orders do
#     Customer
#     |> with_failed_orders()
#     |> list_customers()
#   end
#
#   def get_customer_by_email(email) do
#     Customer
#     |> Repo.get_by(%{email: email})
#   end
#
#   def create_customer(attrs) do
#     %Customer{}
#     |> Customer.changeset(attrs)
#     |> Repo.insert()
#   end
# end
