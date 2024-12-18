defmodule Electo.Things.Thing do
  use Ecto.Schema
  import Ecto.Changeset

  schema "things" do
    field :name, :string
    field :votes, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(thing, attrs) do
    thing
    |> cast(attrs, [:name, :votes])
    |> validate_required([:name, :votes])
  end
end
