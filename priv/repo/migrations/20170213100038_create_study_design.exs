defmodule H3acatalog.Repo.Migrations.CreateStudyDesign do
  use Ecto.Migration

  def change do
    create table(:study_designs, primary_key: false) do
      add :name, :string, primary_key: true
      add :description, :text

      timestamps()
    end

  end
end
