defmodule H3acatalog.IndividualTest do
  use H3acatalog.ModelCase

  alias H3acatalog.Individual

  @valid_attrs %{sex: "some content", species: "some content", study_acronym: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Individual.changeset(%Individual{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Individual.changeset(%Individual{}, @invalid_attrs)
    refute changeset.valid?
  end
end
