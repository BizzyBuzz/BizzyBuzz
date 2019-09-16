defmodule SalesByVendorWeb.ReportController do
  use SalesByVendorWeb, :controller

  alias SalesByVendor.SalesByVendor

  plug :authenticate when action not in [:dashboard]

  def index(conn, params) do
    render(conn, "index.html")
  end

  def dtd(conn, params) do # yesterday
    dtd =
      if conn.assigns.current_user.admin do
        all_vendors_dtd = SalesByVendor.get_all_vendors_dtd()
        total_o = SalesByVendor.calc_total(all_vendors_dtd, :o)
        total_p = SalesByVendor.calc_total(all_vendors_dtd, :p)
        total_s = SalesByVendor.calc_total(all_vendors_dtd, :s)
        total_v = SalesByVendor.calc_total(all_vendors_dtd, :v)
        total_w = SalesByVendor.calc_total(all_vendors_dtd, :w)
        total_z = SalesByVendor.calc_total(all_vendors_dtd, :z)
        total_bb = SalesByVendor.calc_total(all_vendors_dtd, :bb)
        total_cc = SalesByVendor.calc_total(all_vendors_dtd, :cc)
        total_dd = SalesByVendor.calc_total(all_vendors_dtd, :dd)
        total_gg = SalesByVendor.calc_total(all_vendors_dtd, :gg)
        dtd = %{
          sales_by_vendors: all_vendors_dtd, 
          total_o: total_o, 
          total_p: total_p,  
          total_s: total_s, 
          total_v: total_v, 
          total_w: total_w, 
          total_z: total_z, 
          total_bb: total_bb, 
          total_cc: total_cc, 
          total_dd: total_dd, 
          total_gg: total_gg, 
        } 
      else
        username = conn.assigns.current_user.username
        vendor_dtd = SalesByVendor.get_dtd(username)
        total_o = SalesByVendor.calc_total(vendor_dtd, :o)
        total_p = SalesByVendor.calc_total(vendor_dtd, :p)
        total_s = SalesByVendor.calc_total(vendor_dtd, :s)
        total_v = SalesByVendor.calc_total(vendor_dtd, :v)
        total_w = SalesByVendor.calc_total(vendor_dtd, :w)
        total_z = SalesByVendor.calc_total(vendor_dtd, :z)
        total_bb = SalesByVendor.calc_total(vendor_dtd, :bb)
        total_cc = SalesByVendor.calc_total(vendor_dtd, :cc)
        total_dd = SalesByVendor.calc_total(vendor_dtd, :dd)
        total_gg = SalesByVendor.calc_total(vendor_dtd, :gg)
        dtd = %{
          sales_by_vendors: vendor_dtd,
          total_o: total_o, 
          total_p: total_p, 
          total_s: total_s, 
          total_v: total_v, 
          total_w: total_w, 
          total_z: total_z, 
          total_bb: total_bb, 
          total_cc: total_cc, 
          total_dd: total_dd, 
          total_gg: total_gg
        }
      end
    render(conn, "dtd.html", dtd)
  end

  def wtd(conn, params) do
    wtd = 
      if conn.assigns.current_user.admin do
        all_vendors_wtd = SalesByVendor.get_all_vendors_wtd()
        total_o = SalesByVendor.calc_total(all_vendors_wtd, :o)
        total_p = SalesByVendor.calc_total(all_vendors_wtd, :p)
        total_s = SalesByVendor.calc_total(all_vendors_wtd, :s)
        total_v = SalesByVendor.calc_total(all_vendors_wtd, :v)
        total_w = SalesByVendor.calc_total(all_vendors_wtd, :w)
        total_z = SalesByVendor.calc_total(all_vendors_wtd, :z)
        total_bb = SalesByVendor.calc_total(all_vendors_wtd, :bb)
        total_cc = SalesByVendor.calc_total(all_vendors_wtd, :cc)
        total_dd = SalesByVendor.calc_total(all_vendors_wtd, :dd)
        total_gg = SalesByVendor.calc_total(all_vendors_wtd, :gg)
        wtd = %{
          sales_by_vendors: all_vendors_wtd, 
          total_o: total_o, 
          total_p: total_p, 
          total_s: total_s, 
          total_v: total_v, 
          total_w: total_w,  
          total_z: total_z, 
          total_bb: total_bb, 
          total_cc: total_cc, 
          total_dd: total_dd, 
          total_gg: total_gg, 
        } 
      else
        username = conn.assigns.current_user.username
        vendor_wtd = SalesByVendor.get_wtd(username)
        total_o = SalesByVendor.calc_total(vendor_wtd, :o)
        total_p = SalesByVendor.calc_total(vendor_wtd, :p)
        total_s = SalesByVendor.calc_total(vendor_wtd, :s)
        total_v = SalesByVendor.calc_total(vendor_wtd, :v)
        total_w = SalesByVendor.calc_total(vendor_wtd, :w)
        total_z = SalesByVendor.calc_total(vendor_wtd, :z)
        total_bb = SalesByVendor.calc_total(vendor_wtd, :bb)
        total_cc = SalesByVendor.calc_total(vendor_wtd, :cc)
        total_dd = SalesByVendor.calc_total(vendor_wtd, :dd)
        total_gg = SalesByVendor.calc_total(vendor_wtd, :gg)
        wtd = %{
          sales_by_vendors: vendor_wtd, 
          total_o: total_o, 
          total_p: total_p, 
          total_s: total_s, 
          total_v: total_v, 
          total_w: total_w, 
          total_z: total_z,
          total_bb: total_bb, 
          total_cc: total_cc, 
          total_dd: total_dd, 
          total_gg: total_gg 
        } 
      end
    render(conn, "wtd.html", wtd)
  end

  def mtd(conn, params) do
    mtd = 
      if conn.assigns.current_user.admin do
        all_vendors_mtd = SalesByVendor.get_all_vendors_mtd()
        total_o = SalesByVendor.calc_total(all_vendors_mtd, :o)
        total_p = SalesByVendor.calc_total(all_vendors_mtd, :p)
        total_s = SalesByVendor.calc_total(all_vendors_mtd, :s)
        total_v = SalesByVendor.calc_total(all_vendors_mtd, :v)
        total_w = SalesByVendor.calc_total(all_vendors_mtd, :w)
        total_z = SalesByVendor.calc_total(all_vendors_mtd, :z)
        total_bb = SalesByVendor.calc_total(all_vendors_mtd, :bb)
        total_cc = SalesByVendor.calc_total(all_vendors_mtd, :cc)
        total_dd = SalesByVendor.calc_total(all_vendors_mtd, :dd)
        total_gg = SalesByVendor.calc_total(all_vendors_mtd, :gg)
        mtd = %{
          sales_by_vendors: all_vendors_mtd, 
          total_o: total_o, 
          total_p: total_p, 
          total_s: total_s, 
          total_v: total_v, 
          total_w: total_w, 
          total_z: total_z, 
          total_bb: total_bb, 
          total_cc: total_cc, 
          total_dd: total_dd, 
          total_gg: total_gg
        } 
      else
        username = conn.assigns.current_user.username
        vendor_mtd = SalesByVendor.get_mtd(username)
        total_o = SalesByVendor.calc_total(vendor_mtd, :o)
        total_p = SalesByVendor.calc_total(vendor_mtd, :p)
        total_s = SalesByVendor.calc_total(vendor_mtd, :s)
        total_v = SalesByVendor.calc_total(vendor_mtd, :v)
        total_w = SalesByVendor.calc_total(vendor_mtd, :w)
        total_z = SalesByVendor.calc_total(vendor_mtd, :z)
        total_bb = SalesByVendor.calc_total(vendor_mtd, :bb)
        total_cc = SalesByVendor.calc_total(vendor_mtd, :cc)
        total_dd = SalesByVendor.calc_total(vendor_mtd, :dd)
        total_gg = SalesByVendor.calc_total(vendor_mtd, :gg)
        mtd = %{
          sales_by_vendors: vendor_mtd, 
          total_o: total_o, 
          total_p: total_p, 
          total_s: total_s, 
          total_v: total_v, 
          total_w: total_w, 
          total_z: total_z, 
          total_bb: total_bb, 
          total_cc: total_cc, 
          total_dd: total_dd, 
          total_gg: total_gg
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