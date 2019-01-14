defmodule CleanCode.Sales.Customer do
  @moduledoc """
  wip
  """
  alias CleanCode.Customer
  alias CleanCode.Repo
  import CleanCode.CustomerQuery #, only: [duplicate: 2]

  def list_customers(query \\ Customer) do
    Repo.all(query)
  end

  def customers_with_at_least_paid_orders(count) do
    Customer
    |> with_at_least_paid_orders(count)
    |> list_customers()
  end

  def customers_with_failed_orders do
    Customer
    |> with_failed_orders()
    |> list_customers()
  end

  def get_customer_by_email(email) do
    Customer
    |> Repo.get_by(%{email: email})
  end

  def create_customer(attrs) do
    %Customer{}
    |> Customer.changeset(attrs)
    |> Repo.insert()
  end
end
