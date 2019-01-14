defmodule CleanCode.Event do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias CleanCode.Order
  alias CleanCode.User

  schema "events" do
    field :description, :string
    field :published, :boolean, default: false
    field :title, :string
    field :start_at, :utc_datetime
    field :event_at, :utc_datetime

    belongs_to :user, User
    has_many :orders, Order

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:title, :published, :description])
    |> validate_required([:title, :published, :description])
  end
end
