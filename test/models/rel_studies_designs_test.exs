defmodule H3acatalog.RelStudiesDesignsTest do
  use H3acatalog.ModelCase

  alias H3acatalog.RelStudiesDesigns

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = RelStudiesDesigns.changeset(%RelStudiesDesigns{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = RelStudiesDesigns.changeset(%RelStudiesDesigns{}, @invalid_attrs)
    refute changeset.valid?
  end
end
