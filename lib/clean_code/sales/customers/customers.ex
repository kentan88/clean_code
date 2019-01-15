defmodule CleanCode.Customers do
  @moduledoc """
  Customer management use cases.
  """
  import Ecto.Query, only: [from: 2]
  alias CleanCode.Customer

  @spec get_customers(Ecto.Repo.t(), Ecto.Query.t() | term()) :: [Customer.t()]
  def get_customers(repo, query \\ Customer) do
    repo.all(query)
  end

  @spec get_customers_with_at_least_paid_orders(Ecto.Repo.t(), integer()) :: [Customer.t()]
  def get_customers_with_at_least_paid_orders(repo, n) do
    query =
      Customer
      |> with_at_least_paid_orders(n)

    get_customers(repo, query)
  end

  @spec get_customers_with_failed_orders(Ecto.Repo.t()) :: [Customer.t()]
  def get_customers_with_failed_orders(repo) do
    query =
      Customer
      |> with_failed_orders()

    get_customers(repo, query)
  end


  @spec get_customer(Ecto.Repo.t(), integer()) :: Customer.t() | nil
  def get_customer(repo, id) do
    repo.get(Customer, id)
  end

  ##############################################################################
  ################################ queries #####################################
  ##############################################################################

  defp with_at_least_paid_orders(query, n) do
    from(customer in query,
      join: orders in assoc(customer, :orders),
      where: orders.status == "PAID",
      having: count(orders) >= ^n,
      group_by: customer.id
    )
  end

  def with_failed_orders(query) do
    from(customer in query,
      join: orders in assoc(customer, :orders),
      where: orders.status == "FAILED",
      group_by: customer.id
    )
  end

  ##############################################################################
  ##############################################################################
  ##############################################################################
end
