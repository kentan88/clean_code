defmodule CleanCode.User do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias CleanCode.Event

  schema "users" do
    field :active, :boolean, default: false
    field :email, :string
    field :name, :string
    field :password, :string
    has_many :events, Event

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :password, :email, :active])
    |> validate_required([:name, :password, :email, :active])
  end
end
