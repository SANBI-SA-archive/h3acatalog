defmodule H3acatalog.Repo.Migrations.CreateStudy do
  use Ecto.Migration

  def change do
    create table(:studies, primary_key: false) do
      add :study_id, :string, primary_key: true
      add :ega_id, :string
      add :acronym, :string
      add :title, :text
      add :description, :text

      timestamps()
    end

  end
end
