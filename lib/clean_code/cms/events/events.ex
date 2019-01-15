defmodule CleanCode.Events do
  @moduledoc """
  Event management use cases.
  """
  import Ecto.Query, only: [from: 2]
  alias CleanCode.Event

  @spec get_events(Ecto.Repo.t(), Ecto.Query.t() | term()) :: [Event.t()]
  def get_events(repo, query \\ Event) do
    repo.all(query)
  end

  @spec get_published_events(Ecto.Repo.t(), Ecto.Query.t() | term()) :: [Event.t()]
  def get_published_events(repo, query \\ Event) do
    query =
      query
      |> where_published()

    get_events(repo, query)
  end

  @spec get_event(Ecto.Repo.t(), integer()) :: Event.t() | nil
  def get_event(repo, id) do
    repo.get(Event, id)
  end

  defp where_published(query) do
    from(event in query, where: event.published == true)
  end
end
