defmodule H3acatalog.RelStudiesDesigns do
  use H3acatalog.Web, :model

  schema "rel_studies_designs" do
    belongs_to :study, H3acatalog.Study, type: :string
    belongs_to :study_design, H3acatalog.StudyDesign, type: :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
