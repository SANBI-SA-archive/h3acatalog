defmodule H3acatalog.Repo.Migrations.AddFieldsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :name, :string
      add :bio, :string
      add :working_at, :string
      add :photo, :string
      add :role, :string, default: "guest", null: false
    end
  end
end
