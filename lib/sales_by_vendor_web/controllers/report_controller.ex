defmodule SalesByVendorWeb.ReportController do
  use SalesByVendorWeb, :controller

  alias SalesByVendor.SalesByVendor

  plug :authenticate when action not in [:dashboard]

  def index(conn, params) do
    render(conn, "index.html")
  end

  def dtd(conn, params) do
    dtd =
      if conn.assigns.current_user.admin do
        dtd = SalesByVendor.get_dtd(params["date"]) 
      else
        username = conn.assigns.current_user.username
        dtd = SalesByVendor.get_dtd(params["date"], username)
      end
    render(conn, "dtd.html", dtd)
  end

  def mtd(conn, params) do
    mtd = 
      if conn.assigns.current_user.admin do
        mtd = SalesByVendor.get_mtd(params["month"], params["year"]) 
      else
        username = conn.assigns.current_user.username
        mtd = SalesByVendor.get_mtd(params["month"], params["year"], username)
      end
    render(conn, "mtd.html", mtd)
  end

  def ytd(conn, params) do
    ytd = 
      if conn.assigns.current_user.admin do
        ytd = SalesByVendor.get_ytd(params["year"]) 
      else
        username = conn.assigns.current_user.username
        ytd = SalesByVendor.get_ytd(params["year"], username)
      end
    render(conn, "ytd.html", ytd)
  end

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

end