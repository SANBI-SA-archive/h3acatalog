defmodule H3acatalog.PageController do
  use H3acatalog.Web, :controller

  alias H3acatalog.Repo
  alias H3acatalog.Study
  alias H3acatalog.Individual

  def index(conn, _params) do
    studies = Repo.all(Study)
    render conn, "index.html", studies: studies,
      layout: {H3acatalog.LayoutView, "login.html"}
  end

end
