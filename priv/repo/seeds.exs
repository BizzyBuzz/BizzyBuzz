alias NimbleCSV.RFC4180, as: CSVParser
alias SalesByVendor.{SalesByVendor, Accounts, Vendors}

defmodule CsvDb do

  def create_users() do
    Vendors.create_vendor(%{name: "admin", email: "mhm@galtmidas.com"})
    Accounts.register_user(%{
      "credential" => %{
        "email" => "mhm@galtmidas.com",
        "password" => "repidfire23"},
      "name" => "",
      "username" => "admin",
      "admin" => true,
      "verified" => true
    })
  end

  def insert_ytd_sales() do
    "sales-all.csv"
    # "Sales By Vendor - YTD.csv"
    |> File.read!
    |> CSVParser.parse_string([{:skip_headers, false}]) |>
    Enum.map(fn [a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z, aa, bb, cc, dd, ee, ff, gg, hh] -> 
      parts = k |> String.replace("VENDOR: ", "") |> String.split(" -- ")
      k = parts |> Enum.at(0)
      k2 = parts |> Enum.at(1)
      SalesByVendor.create(%{a: a, b: b, c: c, d: d, e: e, f: f, g: g, h: h, i: i, j: j, k: k, k2: k2, l: l, m: m, n: n, o: o, p: p, q: q, r: r, s: s, t: t, u: u, v: v, w: w, x: x, y: y, z: z, aa: aa, bb: bb, cc: cc, dd: dd, ee: ee, ff: ff, gg: gg, hh: hh})
    end)
  end

  def main() do
    CsvDb.create_users()
    CsvDb.insert_ytd_sales()
  end

end

CsvDb.main()