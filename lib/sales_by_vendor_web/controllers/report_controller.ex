defmodule SalesByVendorWeb.ReportController do
  use SalesByVendorWeb, :controller

  alias SalesByVendor.SalesByVendor

  plug :authenticate when action not in [:dashboard]

  def index(conn, params) do
    render(conn, "index.html")
  end

  def dtd(conn, params) do # yesterday
    vendor_dtd = 
      if conn.assigns.current_user.admin do
        all_vendors_dtd = SalesByVendor.get_all_vendors_dtd()
      else
        username = conn.assigns.current_user.username
        vendor_dtd = SalesByVendor.get_dtd(username)
      end
    total_n = SalesByVendor.calc_total(vendor_dtd, :n)
    total_o = SalesByVendor.calc_total(vendor_dtd, :o)
    total_p = SalesByVendor.calc_total(vendor_dtd, :p)
    total_s = SalesByVendor.calc_total(vendor_dtd, :s)
    total_t = SalesByVendor.calc_total(vendor_dtd, :t)
    total_u = SalesByVendor.calc_total(vendor_dtd, :u)
    total_w = SalesByVendor.calc_total(vendor_dtd, :w)
    total_x = SalesByVendor.calc_total(vendor_dtd, :x)
    total_y = SalesByVendor.calc_total(vendor_dtd, :y)
    total_dd = SalesByVendor.calc_total(vendor_dtd, :dd)
    total_ee = SalesByVendor.calc_total(vendor_dtd, :ee)
    total_ff = SalesByVendor.calc_total(vendor_dtd, :ff)
    total_gg = SalesByVendor.calc_total(vendor_dtd, :gg)
    dtd = %{
      sales_by_vendors: vendor_dtd,
      total_n: total_n, 
      total_o: total_o, 
      total_p: total_p, 
      total_s: total_s, 
      total_t: total_t, 
      total_u: total_u, 
      total_w: total_w,
      total_x: total_x,
      total_y: total_y, 
      total_dd: total_dd, 
      total_ee: total_ee, 
      total_ff: total_ff, 
      total_gg: total_gg
    }
    render(conn, "dtd.html", dtd)
  end

  def wtd(conn, params) do
    vendor_wtd = 
      if conn.assigns.current_user.admin do
        all_vendors_wtd = SalesByVendor.get_all_vendors_wtd()
      else
        username = conn.assigns.current_user.username
        vendor_wtd = SalesByVendor.get_wtd(username)
      end
    total_n = SalesByVendor.calc_total(vendor_wtd, :n)
    total_o = SalesByVendor.calc_total(vendor_wtd, :o)
    total_p = SalesByVendor.calc_total(vendor_wtd, :p)
    total_s = SalesByVendor.calc_total(vendor_wtd, :s)
    total_t = SalesByVendor.calc_total(vendor_wtd, :t)
    total_u = SalesByVendor.calc_total(vendor_wtd, :u)
    total_w = SalesByVendor.calc_total(vendor_wtd, :w)
    total_x = SalesByVendor.calc_total(vendor_wtd, :x)
    total_y = SalesByVendor.calc_total(vendor_wtd, :y)
    total_dd = SalesByVendor.calc_total(vendor_wtd, :dd)
    total_ee = SalesByVendor.calc_total(vendor_wtd, :ee)
    total_ff = SalesByVendor.calc_total(vendor_wtd, :ff)
    total_gg = SalesByVendor.calc_total(vendor_wtd, :gg)
    wtd = %{
      sales_by_vendors: vendor_wtd,
      total_n: total_n, 
      total_o: total_o, 
      total_p: total_p, 
      total_s: total_s, 
      total_t: total_t, 
      total_u: total_u, 
      total_w: total_w,
      total_x: total_x,
      total_y: total_y, 
      total_dd: total_dd, 
      total_ee: total_ee, 
      total_ff: total_ff, 
      total_gg: total_gg
    }
    render(conn, "wtd.html", wtd)
  end

  def mtd(conn, params) do
    vendor_mtd = 
      if conn.assigns.current_user.admin do
        all_vendors_mtd = SalesByVendor.get_all_vendors_mtd()
      else
        username = conn.assigns.current_user.username
        vendor_mtd = SalesByVendor.get_mtd(username)
      end
    total_n = SalesByVendor.calc_total(vendor_mtd, :n)
    total_o = SalesByVendor.calc_total(vendor_mtd, :o)
    total_p = SalesByVendor.calc_total(vendor_mtd, :p)
    total_s = SalesByVendor.calc_total(vendor_mtd, :s)
    total_t = SalesByVendor.calc_total(vendor_mtd, :t)
    total_u = SalesByVendor.calc_total(vendor_mtd, :u)
    total_w = SalesByVendor.calc_total(vendor_mtd, :w)
    total_x = SalesByVendor.calc_total(vendor_mtd, :x)
    total_y = SalesByVendor.calc_total(vendor_mtd, :y)
    total_dd = SalesByVendor.calc_total(vendor_mtd, :dd)
    total_ee = SalesByVendor.calc_total(vendor_mtd, :ee)
    total_ff = SalesByVendor.calc_total(vendor_mtd, :ff)
    total_gg = SalesByVendor.calc_total(vendor_mtd, :gg)
    mtd = %{
      sales_by_vendors: vendor_mtd,
      total_n: total_n, 
      total_o: total_o, 
      total_p: total_p, 
      total_s: total_s, 
      total_t: total_t, 
      total_u: total_u, 
      total_w: total_w,
      total_x: total_x,
      total_y: total_y, 
      total_dd: total_dd, 
      total_ee: total_ee, 
      total_ff: total_ff, 
      total_gg: total_gg
    }
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

end

# FOR GARBAGE COLLECTION

# def ytd(conn, params) do
#   ytd = 
#     if conn.assigns.current_user.admin do
#       all_vendors_ytd = SalesByVendor.get_all_vendors_ytd()
#       total_v = SalesByVendor.calc_total(all_vendors_ytd, :v)
#       ytd = %{sales_by_vendors: all_vendors_ytd, total_v: total_v} 
#     else
#       username = conn.assigns.current_user.username
#       vendor_ytd = SalesByVendor.get_ytd(username)
#       total_v = SalesByVendor.calc_total(vendor_ytd, :v)
#       ytd = %{sales_by_vendors: vendor_ytd, total_v: total_v}
#     end
#   render(conn, "ytd.html", ytd)
# end

# mtd = SalesByVendor.get_mtd(params["month"], params["year"]) 
# vendor_dtd = SalesByVendor.get_dtd(vendor, params["date"])