defmodule H3acatalog.Router do
  use H3acatalog.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Openmaize.Authenticate
  end

  scope "/", H3acatalog do
    pipe_through :browser

    get "/", PageController, :index

    get "/login", SessionController, :new
    get "/logout", SessionController, :delete

    get "/todos/:id/complete", TodoController, :complete
    put "/todos/:id/complete", TodoController, :complete

    put "/user/:id/passwd", UserController, :passwd
    get "/user/:id/delete", UserController, :delete
    get "/user/:id/assign", UserController, :assign

    get "/csv/", CsvController, :index
    get "/csv/new", CsvController, :new
    post "/csv/upload", CsvController, :upload
    get "/csv/:file/import", CsvController, :import
    post "/csv/:file/import", CsvController, :import

    get "/dash/", DashController, :index

    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    get "/sessions/confirm_email", SessionController, :confirm_email
    resources "/password_resets", PasswordResetController, only: [:new, :create, :edit, :update]
    resources "/todos", TodoController
  end
end
