defmodule H3acatalog.TodoController do
  use H3acatalog.Web, :controller

  alias H3acatalog.Todo
  alias H3acatalog.User

  def index(conn, _params) do
    user = conn.assigns.current_user
    # There are 3 ways to query database, don't delete the code below, leave them as examples
    # query 1:
    #query = from t in Todo, where: t.user_id == ^user.id
    #todos = Repo.all(query)
    # query 2:
    #todos = from(t in Todo, where: t.user_id == ^user.id) |> Repo.all()
    # query 3:
    todos = Ecto.assoc(user, :todos) |> Repo.all
    render(conn, "index.html", todos: todos)
  end

  def new(conn, _params) do
    #changeset = Todo.changeset(%Todo{})
    user = conn.assigns.current_user
    changeset = Ecto.build_assoc(user, :todos) |> Todo.changeset()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"todo" => todo_params}) do
    #changeset = Todo.changeset(%Todo{}, todo_params)
    user = conn.assigns.current_user
    changeset = Ecto.build_assoc(user, :todos) |> Todo.changeset(todo_params)

    case Repo.insert(changeset) do
      {:ok, _todo} ->
        conn
        |> put_flash(:info, "Todo created successfully.")
        |> redirect(to: todo_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = Repo.get!(Todo, id)
    render(conn, "show.html", todo: todo)
  end

  def edit(conn, %{"id" => id}) do
    todo = Repo.get!(Todo, id)
    changeset = Todo.changeset(todo)
    render(conn, "edit.html", todo: todo, changeset: changeset)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = Repo.get!(Todo, id)
    changeset = Todo.changeset(todo, todo_params)

    case Repo.update(changeset) do
      {:ok, todo} ->
        conn
        |> put_flash(:info, "Todo updated successfully.")
        |> redirect(to: todo_path(conn, :show, todo))
      {:error, changeset} ->
        render(conn, "edit.html", todo: todo, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = Repo.get!(Todo, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(todo)

    conn
    |> put_flash(:info, "Todo deleted successfully.")
    |> redirect(to: todo_path(conn, :index))
  end

  def complete(conn, %{"id" => id}) do
    changeset = Repo.get!(Todo, id)
    changeset = Ecto.Changeset.change changeset, completed: true
    case Repo.update(changeset) do
      {:ok, todo} ->
        conn
        |> put_flash(:info, "Todo marked as completed")
        |> redirect(to: todo_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:info, "Oops, something went wrong")
        |> redirect(to: todo_path(conn, :index))
    end
  end

end
