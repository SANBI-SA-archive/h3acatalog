defmodule H3acatalog.Repo.Migrations.CreateRelStudiesDesigns do
  use Ecto.Migration

  def change do
    create table(:rel_studies_designs) do
      add :study_id, references(:studies, column: :study_id, type: :varchar, on_delete: :nothing)
      add :study_design_id, references(:study_designs, column: :name, type: :varchar, on_delete: :nothing)

      timestamps()
    end
    create index(:rel_studies_designs, [:study_id])
    create index(:rel_studies_designs, [:study_design_id])

  end
end
