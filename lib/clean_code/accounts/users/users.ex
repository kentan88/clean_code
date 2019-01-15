defmodule CleanCode.Users do
  @moduledoc """
  User management use cases.
  """
  import Ecto.Query, only: [from: 2]
  alias CleanCode.User

  @spec get_users(Ecto.Repo.t(), Ecto.Query.t() | term()) :: [User.t()]
  def get_users(repo, query \\ User) do
    repo.all(query)
  end

  @spec get_users_with_name_contains(Ecto.Repo.t(), Ecto.Query.t() | term()) :: [User.t()]
  def get_users_with_name_contains(repo, str) do
    query = from(user in User, where: ilike(user.name, ^"%#{str}%"))
    get_users(repo, query)
  end

  @spec get_active_users(Ecto.Repo.t()) :: [User.t()]
  def get_active_users(repo) do
    query = from(user in User, where: user.active == true)
    get_users(repo, query)
  end

  @spec get_inactive_users(Ecto.Repo.t()) :: [User.t()]
  def get_inactive_users(repo) do
    query = from(user in User, where: user.active != true)
    get_users(repo, query)
  end

  @spec get_user(Ecto.Repo.t(), integer()) :: User.t() | nil
  def get_user(repo, user_id) do
    repo.get(User, user_id)
  end

  @spec get_user_by_name(Ecto.Repo.t(), String.t()) :: User.t() | nil
  def get_user_by_name(repo, name) do
    repo.get_by(User, %{name: name})
  end

  @spec get_active_user_by_name(Ecto.Repo.t(), String.t()) :: User.t() | nil
  def get_active_user_by_name(repo, name) do
    repo.get_by(User, %{active: true, name: name})
  end

  @spec get_active_user_by_email(Ecto.Repo.t(), String.t()) :: User.t() | nil
  def get_active_user_by_email(repo, email) do
    repo.get_by(User, %{active: true, email: email})
  end
end
