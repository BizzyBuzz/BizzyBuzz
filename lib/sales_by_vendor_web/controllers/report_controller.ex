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
        all_vendors_dtd = SalesByVendor.get_all_vendors_dtd()
        total_n = SalesByVendor.calc_total(all_vendors_dtd, :n)
        total_q = SalesByVendor.calc_total(all_vendors_dtd, :q)
        total_t = SalesByVendor.calc_total(all_vendors_dtd, :t)
        total_v = SalesByVendor.calc_total(all_vendors_dtd, :v)
        total_w = SalesByVendor.calc_total(all_vendors_dtd, :w)
        dtd = %{
          sales_by_vendors: all_vendors_dtd, 
          total_n: total_n, 
          total_q: total_q, 
          total_t: total_t, 
          total_v: total_v, 
          total_w: total_w
        } 
      else
        username = conn.assigns.current_user.username
        vendor_dtd = SalesByVendor.get_dtd(username)
        total_n = SalesByVendor.calc_total(vendor_dtd, :n)
        total_q = SalesByVendor.calc_total(vendor_dtd, :q)
        total_t = SalesByVendor.calc_total(vendor_dtd, :t)
        total_v = SalesByVendor.calc_total(vendor_dtd, :v)
        total_w = SalesByVendor.calc_total(vendor_dtd, :w)
        dtd = %{
          sales_by_vendors: vendor_dtd, 
          total_n: total_n, 
          total_q: total_q, 
          total_t: total_t, 
          total_v: total_v, 
          total_w: total_w
        }
      end
    render(conn, "dtd.html", dtd)
  end

  def wtd(conn, params) do
    wtd = 
      if conn.assigns.current_user.admin do
        all_vendors_wtd = SalesByVendor.get_all_vendors_wtd()
        total_n = SalesByVendor.calc_total(all_vendors_wtd, :n)
        total_q = SalesByVendor.calc_total(all_vendors_wtd, :q)
        total_t = SalesByVendor.calc_total(all_vendors_wtd, :t)
        total_v = SalesByVendor.calc_total(all_vendors_wtd, :v)
        total_w = SalesByVendor.calc_total(all_vendors_wtd, :w)
        dtd = %{
          sales_by_vendors: all_vendors_wtd, 
          total_n: total_n, 
          total_q: total_q, 
          total_t: total_t, 
          total_v: total_v, 
          total_w: total_w
        } 
      else
        username = conn.assigns.current_user.username
        vendor_wtd = SalesByVendor.get_wtd(username)
        total_n = SalesByVendor.calc_total(vendor_wtd, :n)
        total_q = SalesByVendor.calc_total(vendor_wtd, :q)
        total_t = SalesByVendor.calc_total(vendor_wtd, :t)
        total_v = SalesByVendor.calc_total(vendor_wtd, :v)
        total_w = SalesByVendor.calc_total(vendor_wtd, :w)
        dtd = %{
          sales_by_vendors: vendor_wtd, 
          total_n: total_n, 
          total_q: total_q, 
          total_t: total_t, 
          total_v: total_v, 
          total_w: total_w
        } 
      end
    render(conn, "wtd.html", wtd)
  end

  def mtd(conn, params) do
    mtd = 
      if conn.assigns.current_user.admin do
        all_vendors_mtd = SalesByVendor.get_all_vendors_mtd()
        total_n = SalesByVendor.calc_total(all_vendors_mtd, :n)
        total_q = SalesByVendor.calc_total(all_vendors_mtd, :q)
        total_t = SalesByVendor.calc_total(all_vendors_mtd, :t)
        total_v = SalesByVendor.calc_total(all_vendors_mtd, :v)
        total_w = SalesByVendor.calc_total(all_vendors_mtd, :w)
        dtd = %{
          sales_by_vendors: all_vendors_mtd, 
          total_n: total_n, 
          total_q: total_q, 
          total_t: total_t, 
          total_v: total_v, 
          total_w: total_w
        } 
      else
        username = conn.assigns.current_user.username
        vendor_mtd = SalesByVendor.get_mtd(username)
        total_v = SalesByVendor.calc_total(vendor_mtd, :v)
        total_n = SalesByVendor.calc_total(vendor_mtd, :n)
        total_q = SalesByVendor.calc_total(vendor_mtd, :q)
        total_t = SalesByVendor.calc_total(vendor_mtd, :t)
        total_v = SalesByVendor.calc_total(vendor_mtd, :v)
        total_w = SalesByVendor.calc_total(vendor_mtd, :w)
        dtd = %{
          sales_by_vendors: vendor_mtd, 
          total_n: total_n, 
          total_q: total_q, 
          total_t: total_t, 
          total_v: total_v, 
          total_w: total_w
        } 
      end
    render(conn, "mtd.html", mtd)
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

  def ytd(conn, params) do
    ytd = 
      if conn.assigns.current_user.admin do
        all_vendors_ytd = SalesByVendor.get_all_vendors_ytd()
        total_v = SalesByVendor.calc_total(all_vendors_ytd, :v)
        ytd = %{sales_by_vendors: all_vendors_ytd, total_v: total_v} 
      else
        username = conn.assigns.current_user.username
        vendor_ytd = SalesByVendor.get_ytd(username)
        total_v = SalesByVendor.calc_total(vendor_ytd, :v)
        ytd = %{sales_by_vendors: vendor_ytd, total_v: total_v}
      end
    render(conn, "ytd.html", ytd)
  end

end

# mtd = SalesByVendor.get_mtd(params["month"], params["year"]) 
# vendor_dtd = SalesByVendor.get_dtd(vendor, params["date"])