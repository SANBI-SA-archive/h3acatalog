defmodule H3acatalog.User do
  use H3acatalog.Web, :model
  use Arc.Ecto.Schema

  alias Openmaize.Database, as: DB

  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :confirmed_at, Ecto.DateTime
    field :confirmation_token, :string
    field :confirmation_sent_at, Ecto.DateTime
    field :reset_token, :string
    field :reset_sent_at, Ecto.DateTime
    field :name, :string
    field :bio, :string
    field :working_at, :string
    field :photo, H3acatalog.Photo.Type
    field :role, :string, default: "guest"
    has_many :todos, H3acatalog.Todo

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :email, :name, :bio, :working_at, :role])
    |> cast_attachments(params, [:photo])
    |> validate_required([:username, :email, :role])
    |> unique_constraint(:username)
  end
  
  def pass_changeset(struct, params \\ %{}) do
    struct
    |> DB.add_password_hash(params)
  end

  def auth_changeset(struct, params, key) do
    struct
    |> changeset(params)
    |> DB.add_password_hash(params)
    |> DB.add_confirm_token(key)
  end

  def reset_changeset(struct, params, key) do
    struct
    |> cast(params, [:email])
    |> validate_required([:email])
    |> DB.add_reset_token(key)
  end
end
