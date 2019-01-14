defmodule CleanCode.CMS do
  @moduledoc """
  This module provides a public API for the CMS context
  """
  alias CleanCode.Event
  alias CleanCode.Repo

  def get_event(id) do
    Repo.get(Event, id)
  end
end
