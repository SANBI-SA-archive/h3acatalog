defmodule H3acatalog.DashController do
  use H3acatalog.Web, :controller

  alias H3acatalog.Repo
  alias H3acatalog.User
  alias H3acatalog.Study
  alias H3acatalog.Individual

  def index(conn, _params) do
    users = Repo.all(User)
    studies = Repo.all(Study)
    individuals = Repo.all(Individual) 
    render(conn, "index.html", users: users, studies: studies, individuals: individuals)
  end
end
