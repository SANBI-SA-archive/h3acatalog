defmodule H3acatalog.StudyDesign do
  use H3acatalog.Web, :model

  @primary_key {:name, :string, []}
  @derive {Phoenix.Param, key: :name}
  schema "study_designs" do
    field :description, :string

    has_many :rel_studies_designs, H3acatalog.RelStudiesDesigns
    has_many :studies, through: [:rel_studies_designs, :study]

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description])
    |> validate_required([:name, :description])
  end
end
