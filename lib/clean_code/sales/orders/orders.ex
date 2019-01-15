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

  @spec get_paid_orders_for_event(Ecto.Repo.t(), Event.t() | term()) :: [Order.t()]
  def get_paid_orders_for_event(repo, %Event{} = event) do
    query =
      Order
      |> paid()
      |> for_event(event)

    get_orders(repo, query)
  end

  @spec get_pending_payment_orders_for_event(Ecto.Repo.t(), Event.t()) :: [
          Order.t()
        ]
  def get_pending_payment_orders_for_event(repo, %Event{} = event) do
    query =
      Order
      |> pending_payment()
      |> for_event(event)

    get_orders(repo, query)
  end

  @spec create_order(Ecto.Repo.t(), Order.order_attrs()) ::
          {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
  def create_order(repo, order_attrs) do
    %Order{}
    |> Order.changeset(order_attrs)
    |> repo.insert()
  end

  # just to understand how typespec work
  # CleanCode.Orders.really_create_order(CleanCode.Repo)
  def really_create_order(repo) do
    customer = CleanCode.Customers.get_customer(CleanCode.Repo, 1)  #try this as well -> %CleanCode.Customer{}
    event = CleanCode.Events.get_event(CleanCode.Repo, 1) #try this as well ->  %CleanCode.Event{} 
    create_order(repo, %{status: "hello", customer: customer, event: event})
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

# CleanCode.Orders.get_paid_orders_for_event(CleanCode.Repo, CleanCode.Events.get_event(CleanCode.Repo, 1))
