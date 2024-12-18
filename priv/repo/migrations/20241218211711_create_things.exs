defmodule Electo.Repo.Migrations.CreateThings do
  use Ecto.Migration

  def change do
    create table(:things) do
      add :name, :string
      add :votes, :integer, default: 0

      timestamps(type: :utc_datetime)
    end
  end
end
