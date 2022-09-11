defmodule Fawkes.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
      add :desc, :text

      timestamps()
    end

    create unique_index(:rooms, [:name])
  end
end
