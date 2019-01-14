defmodule CleanCode.EventQuery do
  @moduledoc false
  import Ecto.Query

  def where_published(query) do
    where(query, [event], event.published == true)
  end
end
