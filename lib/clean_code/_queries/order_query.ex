defmodule CleanCode.OrderQuery do
  @moduledoc false
  import Ecto.Query

  def paid(query \\ Order) do
    query
    |> where([o], o.status == "PAID")
  end

  def pending_payment(query \\ Order) do
    query
    |> where([o], o.status == "PENDING_PAYMENT")
  end

  def for_event(query, event) do
    query
    |> join(
      :left,
      [o],
      event in assoc(o, :event)
    )
    |> where([_o, e], e.id == ^event.id)
  end
end
