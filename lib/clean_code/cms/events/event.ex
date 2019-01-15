defmodule CleanCode.Event do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias CleanCode.Order
  alias CleanCode.User

  @type t :: %__MODULE__{
          id: integer(),
          title: String.t(),
          description: String.t(),
          published: boolean(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  @type event_attrs :: %{
          title: String.t(),
          description: String.t(),
          published: boolean()
        }

  schema "events" do
    field :description, :string
    field :published, :boolean, default: false
    field :title, :string
    field :start_at, :utc_datetime

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

# defmodule CleanCode.CMS.Event do
#   @moduledoc """
#   wip
#   """
#   alias CleanCode.Event
#   import CleanCode.EventQuery
#   alias CleanCode.Repo
#
#   def list_events(query \\ Event) do
#     Repo.all(query)
#   end
#
#   def list_published_events do
#     Event
#     |> where_published()
#     |> list_events()
#   end
#
#   def get_event(id) do
#     Repo.get(Event, id)
#   end
# end
