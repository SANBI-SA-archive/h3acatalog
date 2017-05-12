defmodule H3acatalog.Repo.Migrations.CreateIndividual do
  use Ecto.Migration

  def change do
    create table(:individuals, primary_key: false) do
      add :individual_id, :string, primary_key: true
      add :species, :string
      add :sex, :string
      add :ethnicity, :string
      add :study_id, references(:studies, column: :study_id, type: :varchar, on_delete: :nothing)

      timestamps()
    end
    create index(:individuals, [:study_id])

  end
end
