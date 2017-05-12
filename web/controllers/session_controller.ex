defmodule H3acatalog.SessionController do
  use H3acatalog.Web, :controller

  import H3acatalog.Authorize
  alias H3acatalog.Email

  plug Openmaize.ConfirmEmail,
    [mail_function: &Email.receipt_confirm/1] when action in [:confirm_email]

  plug Openmaize.Login when action in [:create]
  #plug Openmaize.Login, [unique_id: :email] when action in [:create]

  def new(conn, _params) do
    #render conn, "new.html"
    render conn, "new.html",
      layout: {H3acatalog.LayoutView, "login.html"}
  end

  def create(%Plug.Conn{private: %{openmaize_error: message}} = conn, _params) do
    auth_error conn, message, session_path(conn, :new)
  end
  def create(%Plug.Conn{private: %{openmaize_user: %{id: id}}} = conn, _params) do
    put_session(conn, :user_id, id)
    |> auth_info("You have been logged in", dash_path(conn, :index))
  end

  def delete(conn, _params) do
    configure_session(conn, drop: true)
    |> auth_info("You have been logged out", page_path(conn, :index))
  end

  def confirm_email(%Plug.Conn{private: %{openmaize_error: message}} = conn, _params) do
    auth_error conn, message, session_path(conn, :new)
  end
  def confirm_email(%Plug.Conn{private: %{openmaize_info: message}} = conn, _params) do
    auth_info conn, message, session_path(conn, :new)
  end
end
