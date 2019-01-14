defmodule CleanCode.CMS.Event do
  @moduledoc """
  wip
  """
  alias CleanCode.Event
  import CleanCode.EventQuery
  alias CleanCode.Repo

  def list_events(query \\ Event) do
    Repo.all(query)
  end

  def list_published_events do
    Event
    |> where_published()
    |> list_events()
  end
end
