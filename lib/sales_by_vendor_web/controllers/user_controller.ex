defmodule SalesByVendorWeb.UserController do 
  use SalesByVendorWeb, :controller
  alias SalesByVendor.Accounts
  alias SalesByVendor.Accounts.User
  alias SalesByVendorWeb.Router.Helpers, as: Routes

  plug :authenticate when action in [:index, :show]
  # plug :only_admin when action in [:new]

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page") 
      |> redirect(to: Routes.session_path(conn, :new))
      |> halt()
    end 
  end

  # defp only_admin(conn, _opts) do
  #   if conn.assigns.current_user && conn.assigns.current_user.admin do
  #     conn
  #   else
  #     conn
  #     |> put_flash(:error, "You must be logged in as admin to access that page") 
  #     |> redirect(to: Routes.session_path(conn, :new))
  #     |> halt()
  #   end 
  # end

  def create(conn, %{"user" => user_params}) do 
    case Accounts.register_user(user_params) do
      {:ok, user} -> 
        token = Phoenix.Token.sign(conn, "user auth", user.id)
        verification_url = Routes.user_url(conn, :verify_email, token: token)
        SalesByVendorWeb.Auth.send_account_verification_email(conn, user, verification_url)
        conn
        # |> SalesByVendorWeb.Auth.login(user)
        |> put_flash(:info, "#{user.name} created! confirmation email sent.")
        |> redirect(to: Routes.session_path(conn, :new))
      {:error, %Ecto.Changeset{} = changeset} -> 
        render(conn, "new.html", changeset: changeset)
      {:error, :no_record} -> 
        render(conn, "new.html", error: :no_record)
    end 
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{}) 
    render(conn, "new.html", changeset: changeset)
  end
  
  def index(conn, _params) do
    users = Accounts.list_users() 
    render(conn, "index.html", users: users)
  end 

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user(id) 
    render(conn, "show.html", user: user)
  end

  def verify_email(conn, params) do
    %{"token" => token} = params
    with {:ok, user_id} <- SalesByVendorWeb.Auth.verify_new_account_token(conn, token), 
      user <- SalesByVendor.Accounts.get_user(user_id) 
    do
      SalesByVendor.Accounts.mark_as_verified(user)
      render(conn, "verified.html")
    else
      _ -> 
        render(conn, "invalid_token.html")
    end
  end

end