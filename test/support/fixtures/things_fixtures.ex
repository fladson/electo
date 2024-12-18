defmodule Electo.ThingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Electo.Things` context.
  """

  @doc """
  Generate a thing.
  """
  def thing_fixture(attrs \\ %{}) do
    {:ok, thing} =
      attrs
      |> Enum.into(%{
        name: "some name",
        votes: 42
      })
      |> Electo.Things.create_thing()

    thing
  end
end
