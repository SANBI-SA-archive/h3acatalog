defmodule H3acatalog.Todo do
  use H3acatalog.Web, :model

  schema "todos" do
    field :title, :string
    field :completed, :boolean, default: false
    belongs_to :user, H3acatalog.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :completed])
    |> validate_required([:title, :completed])
  end
end
