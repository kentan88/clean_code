defmodule CleanCode.Sales.Order do
  @moduledoc """
  wip
  """
  alias CleanCode.Event
  alias CleanCode.Order
  alias CleanCode.OrderQuery
  alias CleanCode.Repo

  def list_orders(query \\ Order) do
    Repo.all(query)
  end

  def paid_orders_for_event(%Event{} = _event) do
    event = CleanCode.CMS.get_event(1)

    Order
    |> OrderQuery.paid()
    |> OrderQuery.for_event(event)
    |> list_orders()
  end

  def pending_payment_orders_for_event(%Event{} = event) do
    Order
    |> OrderQuery.pending_payment()
    |> OrderQuery.for_event(event)
    |> list_orders()
  end

  def create_order(attrs \\ %{}) do
    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end
end
