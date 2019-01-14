defmodule CleanCode.CMS do
  @moduledoc """
  This module provides a public API for the CMS context
  """
  alias CleanCode.CMS
  alias CleanCode.Event
  alias CleanCode.Repo

  defdelegate list_published_events(), to: CMS.Event

  def get_event(id) do
    Repo.get(Event, id)
  end
end
