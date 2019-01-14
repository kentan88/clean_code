defmodule CleanCode.UserQuery do
  @moduledoc false
  import Ecto.Query

  def where_name_eq(query, str) do
    where(query, [user], user.name == ^str)
  end

  def where_active(query) do
    where(query, [user], user.active == true)
  end

  def where_not_active(query) do
    where(query, [user], user.active == false)
  end
end
