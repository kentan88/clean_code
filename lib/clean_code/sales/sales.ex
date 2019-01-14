defmodule CleanCode.Sales do
  @moduledoc """
  This module provides a public API for the Sales context
  """
  alias CleanCode.Sales.Customer
  alias CleanCode.Sales.Order

  defdelegate customers_with_at_least_paid_orders(n), to: Customer
  defdelegate customers_with_failed_orders, to: Customer
  defdelegate get_customer_by_email(email), to: Customer
  defdelegate create_customer(attrs), to: Customer

  defdelegate paid_orders_for_event(event), to: Order
  defdelegate pending_payment_orders_for_event(event), to: Order
  defdelegate create_order(attrs), to: Order
end
