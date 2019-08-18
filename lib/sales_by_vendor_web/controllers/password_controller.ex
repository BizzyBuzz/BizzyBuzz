defmodule SalesByVendorWeb.PasswordController do
  use SalesByVendorWeb, :controller

  alias SalesByVendor.{
    Repo, 
    Accounts, 
    Accounts.Credential, 
    Accounts.User
  }
  alias SalesByVendorWeb.Router.Helpers, as: Routes

  def new(conn, _params) do
    changeset = Credential.email_changeset(%Credential{}, _params)
    render(conn, "new.html", changeset: changeset, action: Routes.password_path(conn, :create))
  end

  def create(conn, params) do
    username = params["username"]
    email = params["credential"]["email"]
    user = case username do # user = case email do
      nil ->
        nil
      username -> 
        Accounts.get_user_by_username(username)
      # email ->
      #   Accounts.get_user_by_email(email)
    end
    case user do
      nil ->
        conn
        |> put_flash(:error, "Could not send reset email. Please try again later")
        |> redirect(to: Routes.password_path(conn, :new))
      user ->
        user = reset_password_token(user)
        verification_url = Routes.password_url(conn, :edit, token: user.reset_password_token)
        SalesByVendorWeb.Auth.send_reset_email(conn, email, verification_url)
        conn
        |> put_flash(:info, "If your email address exists in our database, you will receive a password reset link at your email address in a few minutes.")
        |> redirect(to: Routes.password_path(conn, :new))
    end
  end

  def edit(conn, %{"token" => token}) do
    # setup edit page for subsequent update 
    user = Accounts.get_user_by(%{reset_password_token: token})
    case user do
      nil ->
        conn
        |> put_flash(:error, "Invalid reset token")
        |> redirect(to: Routes.password_path(conn, :new))
      user ->
        if !expired?(user.reset_token_sent_at) do
          changeset = Credential.password_changeset(%Credential{})
          conn
          |> render("edit.html", changeset: changeset, token: token)
        else
          User.password_token_changeset(user, %{
            reset_password_token: nil,
            reset_token_sent_at: nil
          })
          |> Repo.update!
          conn
          |> put_flash(:error, "Password reset token expired")
          |> redirect(to: Routes.password_path(conn, :new))
        end
    end
  end

  def update(conn, params) do
    %{"token" => token, "credential" => credential} = params
    %{"password" => password, "password_confirmation" => password_confirmation} = credential
    user = Accounts.get_user_by_reset_password_token(token)
    case user do
      nil ->
        conn
        |> put_flash(:error, "Invalid reset token")
        |> redirect(to: Routes.password_path(conn, :new))
      user ->
        if !expired?(user.reset_token_sent_at) do
          changeset = Credential.password_changeset(user.credential, credential)
          case Repo.update(changeset) do
            {:ok, _user} -> 
              User.password_token_changeset(user, %{
                reset_password_token: nil,
                reset_token_sent_at: nil
              })
              |> Repo.update!
              conn
              |> put_flash(:info, "Password reset successfully!")
              |> redirect(to: Routes.session_path(conn, :new))
            {:error, changeset} ->
              conn
              |> render("edit.html", changeset: changeset, token: token)
          end
        else
          User.password_token_changeset(user, %{
            reset_password_token: nil,
            reset_token_sent_at: nil
          })
          |> Repo.update!
          conn
          |> put_flash(:error, "Password reset token expired")
          |> redirect(to: Routes.password_path(conn, :new))
        end
    end
  end

  defp reset_password_token(user) do
    token = random_string(48)
    sent_at = DateTime.utc_now
    user
    |> User.password_token_changeset(%{reset_password_token: token, reset_token_sent_at: sent_at})
    |> Repo.update!
  end

  defp random_string(length) do
    length
    |> :crypto.strong_rand_bytes
    |> Base.url_encode64
    |> binary_part(0, length)
  end

  defp expired?(datetime) do
    Timex.after?(Timex.now, Timex.shift(datetime, days: 1))
  end

end