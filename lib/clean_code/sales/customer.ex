defmodule CleanCode.Sales.Customer do
  @moduledoc """
  wip
  """
  alias CleanCode.Customer
  alias CleanCode.CustomerQuery
  alias CleanCode.Repo

  def list_customers(query \\ Customer) do
    Repo.all(query)
  end

  def customers_with_at_least_paid_orders(count) do
    Customer
    |> CustomerQuery.with_at_least_paid_orders(count)
    |> list_customers()
  end

  def customers_with_failed_orders do
    Customer
    |> CustomerQuery.with_failed_orders()
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
