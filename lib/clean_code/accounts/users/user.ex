defmodule CleanCode.User do
  @moduledoc false
  use CleanCode.Schema
  alias CleanCode.Event

  @type t :: %__MODULE__{
          id: integer(),
          email: String.t(),
          name: String.t(),
          password: String.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

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
