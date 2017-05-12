defmodule H3acatalog.Individual do
  use H3acatalog.Web, :model

  @primary_key {:individual_id, :string, []}
  @derive {Phoenix.Param, key: :individual_id}
  schema "individuals" do
    field :species, :string
    field :sex, :string
    field :ethnicity, :string
    belongs_to :study, H3acatalog.Study, type: :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:individual_id, :study_id, :species, :sex, :ethnicity])
    |> validate_required([:individual_id, :study_id, :species, :sex, :ethnicity])
  end
end
