defmodule CleanCode.Accounts.User do
  @moduledoc """
  This module provides a public API for the Accounts context
  """
  alias CleanCode.User
  alias CleanCode.Repo
  alias CleanCode.UserQuery

  def list_users(query \\ User) do
    Repo.all(query)
  end

  def list_active_users do
    User
    |> UserQuery.where_active()
    |> list_users()
  end

  def list_inactive_users do
    User
    |> UserQuery.where_not_active()
    |> list_users()
  end
end
