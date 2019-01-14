defmodule CleanCode.Accounts do
  @moduledoc """
  This module provides a public API for the Accounts context
  """
  alias CleanCode.Accounts.User

  defdelegate list_users, to: User
  defdelegate list_active_users, to: User
  defdelegate list_inactive_users, to: User
end
