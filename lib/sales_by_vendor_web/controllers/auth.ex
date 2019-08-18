defmodule SalesByVendorWeb.Auth do 
  import Plug.Conn
  alias SalesByVendor.Accounts

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    cond do
      user = conn.assigns[:current_user] -> 
        put_current_user(conn, user)
      user = user_id && Accounts.get_user(user_id) ->
        put_current_user(conn, user)
      true ->
        assign(conn, :current_user, nil)
      end 
  end

  def login(conn, user) do
    conn
    |> put_current_user(user)
    # |> assign(:current_user, user)
    |> put_session(:user_id, user.id) 
    |> configure_session(renew: true)
  end

  def login_by_email_and_pass(conn, email, given_pass) do
    case Accounts.authenticate_by_email_and_pass(email, given_pass) do
      {:ok, user} -> {:ok, login(conn, user)}
      {:error, :unauthorized} -> {:error, :unauthorized, conn} 
      {:error, :not_found} -> {:error, :not_found, conn}
    end 
  end

  def logout(conn) do 
    configure_session(conn, drop: true)
  end

  defp put_current_user(conn, user) do
    token = Phoenix.Token.sign(conn, "user socket", user.id)
    conn
    |> assign(:current_user, user) 
    |> assign(:user_token, token) 
  end

  def send_account_verification_email(conn, user, verification_url) do
    SalesByVendorWeb.Email.send(user.credential.email, verification_url) 
  end

  def send_reset_email(conn, email_address, reset_password_url) do
    SalesByVendorWeb.Email.send(email_address, reset_password_url)
  end

  def verify_new_account_token(conn, token) do
    max_age = 86_400 # tokens that are older than a day should be invalid
    Phoenix.Token.verify(conn, "user auth", token, max_age: max_age)
  end

end