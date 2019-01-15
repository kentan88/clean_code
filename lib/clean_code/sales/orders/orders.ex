defmodule CleanCode.Orders do
  @moduledoc """
  Order management use cases.
  """
  import Ecto.Query, only: [from: 2]
  alias CleanCode.Event
  alias CleanCode.Order

  @spec get_orders(Ecto.Repo.t(), Ecto.Query.t() | term()) :: [Order.t()]
  def get_orders(repo, query \\ Order) do
    repo.all(query)
  end

  @spec get_paid_orders_for_event(Ecto.Repo.t(), Ecto.Query.t() | term()) :: [Order.t()]
  def get_paid_orders_for_event(repo, %Event{} = event) do
    query =
      Order
      |> paid()
      |> for_event(event)

    get_orders(repo, query)
  end

  @spec get_pending_payment_orders_for_event(Ecto.Repo.t(), Ecto.Query.t() | term()) :: [
          Order.t()
        ]
  def get_pending_payment_orders_for_event(repo, %Event{} = event) do
    query =
      Order
      |> pending_payment()
      |> for_event(event)

    get_orders(repo, query)
  end

  # @spec create_order(Ecto.Repo.t(), Order.order_attrs()) :: {atom(), Ecto.Changeset.t()}
  @spec create_order(Ecto.Repo.t(), Order.order_attrs()) :: any() #the return type is wrong. {:ok, changeset}

  def create_order(repo, order_attrs) do
    %Order{}
    |> Order.changeset(order_attrs)
    |> repo.insert()
  end

  ##############################################################################
  ################################ queries #####################################
  ##############################################################################

  defp paid(query) do
    from(order in query, where: order.status == "PAID")
  end

  defp pending_payment(query) do
    from(order in query, where: order.status == "PENDING_PAYMENT")
  end

  defp for_event(query, event) do
    from(order in query,
      join: event in assoc(order, :event),
      where: event.id == ^event.id
    )
  end

  ##############################################################################
  ##############################################################################
  ##############################################################################
end
