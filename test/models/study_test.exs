defmodule H3acatalog.StudyTest do
  use H3acatalog.ModelCase

  alias H3acatalog.Study

  @valid_attrs %{acronym: "some content", description: "some content", ega_id: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Study.changeset(%Study{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Study.changeset(%Study{}, @invalid_attrs)
    refute changeset.valid?
  end
end
