defmodule SalesByVendorWeb.SessionController do 
  use SalesByVendorWeb, :controller
  
  def new(conn, _) do 
    render(conn, "new.html")
  end 

  def create(conn, %{"session" => %{"username" => username, "password" => pass}}) do 
    case SalesByVendorWeb.Auth.login_by_username_and_pass(conn, username, pass) do
      {:ok, conn} -> 
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.page_path(conn, :dashboard))
      {:error, _reason, conn} -> 
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html") 
    end
  end


  # def create(conn, %{"session" => %{"email" => email, "password" => pass}}) do 
  #   case SalesByVendorWeb.Auth.login_by_email_and_pass(conn, email, pass) do
  #     {:ok, conn} -> 
  #       conn
  #       |> put_flash(:info, "Welcome back!")
  #       |> redirect(to: Routes.page_path(conn, :dashboard))
  #     {:error, _reason, conn} -> 
  #       conn
  #       |> put_flash(:error, "Invalid email/password combination")
  #       |> render("new.html") 
  #   end
  # end

  def delete(conn, _) do 
    conn
    |> SalesByVendorWeb.Auth.logout()
    |> redirect(to: Routes.page_path(conn, :dashboard)) 
  end

end