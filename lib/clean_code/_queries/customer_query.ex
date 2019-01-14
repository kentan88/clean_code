defmodule CleanCode.CustomerQuery do
  @moduledoc false
  import Ecto.Query

  def with_at_least_paid_orders(query, n) do
    query
    |> join(
      :left,
      [user],
      order in assoc(user, :orders)
    )
    |> where([_user, orders], orders.status == "PAID")
    |> having([_user, orders], count(orders) >= ^n)
    |> group_by([user, _orders], user.id)
  end

  def with_failed_orders(query) do
    query
    |> join(
      :left,
      [user],
      order in assoc(user, :orders)
    )
    |> where([_user, orders], orders.status == "FAILED")
    |> group_by([user, _orders], user.id)
  end
end
