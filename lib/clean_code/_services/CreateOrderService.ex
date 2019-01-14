defmodule BetterCode.CreateOrderService do
  alias CleanCode.CMS
  alias CleanCode.Sales

  @moduledoc """
  This module provides a public API for creating a order
  """
  def process(attrs) do
    event = CMS.get_event(attrs.event_id)
    {:ok, customer} = find_or_create_customer(attrs)

    attrs
    |> merge_params(customer: customer, event: event)
    |> Sales.create_order()
  end

  defp merge_params(attrs, customer: customer, event: event) do
    attrs
    |> Map.put(:customer, customer)
    |> Map.put(:event, event)
  end

  defp find_or_create_customer(attrs) do
    customer = Sales.get_customer_by_email(attrs.email)

    case customer do
      nil -> Sales.create_customer(attrs)
      customer -> {:ok, customer}
    end
  end
end

# recompile && BetterCode.CreateOrderService.process(%{event_id: 1, first_name: "Random", last_name: "Dude", email: Faker.Internet.email(), mobile_no: "91234567", status: "PENDING_PAYMENT"})
