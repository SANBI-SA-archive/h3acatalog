defmodule H3acatalog.Email do
  use Bamboo.Phoenix, view: H3acatalog.EmailView

  alias H3acatalog.Mailer

  @moduledoc """
  A module for sending emails

  Our emails can be sent as pure text, HTML or even as an application view, but
  to keep it simple we will use text only in the examples below.
  Check the Phoenix Framework docs (http://www.phoenixframework.org/docs/sending-email)
  for more details on how to send other types of emails
  """

  @doc """
  An email with a confirmation link in it.
  """
  def ask_confirm(email, link) do
    new_email()
    |> to(email)
    |> from("admin@sanbi.ac.za")
    |> subject("Confirm your account - H3acatalog")
    #|> text_body("Confirm your H3acatalog email here http://localhost:4000/sessions/confirm_email?#{link}")
    |> text_body("Confirm your H3acatalog email here http://h3acatalog.sanbi.ac.za/sessions/confirm_email?#{link}")
    |> Mailer.deliver_now
  end

  @doc """
  An with a link to reset the password.
  """
  def ask_reset(email, link) do
    new_email()
    |> to(email)
    |> from("admin@sanbi.ac.za")
    |> subject("Reset your password - H3acatalog")
    #|> text_body("Reset your password at http://locahost:4000/password_resets/edit?#{link}")
    |> text_body("Reset your password at http://h3acatalog.sanbi.ac.za/password_resets/edit?#{link}")
    |> Mailer.deliver_now
  end

  @doc """
  An email acknowledging that the account has been successfully confirmed.
  """
  def receipt_confirm(email) do
    new_email()
    |> to(email)
    |> from("admin@sanbi.ac.za")
    |> subject("Confirmed account - H3acatalog")
    |> text_body("Your account has been confirmed!")
    |> Mailer.deliver_now
  end
end
