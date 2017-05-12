defmodule H3acatalog.Study do
  use H3acatalog.Web, :model

  @primary_key {:study_id, :string, []}
  @derive {Phoenix.Param, key: :study_id}
  schema "studies" do
    field :ega_id, :string
    field :acronym, :string
    field :title, :string
    field :description, :string

    has_many :rel_studies_designs, H3acatalog.RelStudiesDesigns
    has_many :study_designs, through: [:rel_studies_designs, :study_design]

    has_many :individuals, H3acatalog.Individual

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:study_id, :acronym, :title, :description])
    |> validate_required([:study_id, :acronym, :title, :description])
  end
end
