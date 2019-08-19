alias NimbleCSV.RFC4180, as: CSVParser
alias SalesByVendor.{SalesByVendor, Accounts}

defmodule CsvDb do

  def create_users() do
    Accounts.register_user(%{
      "credential" => %{
        "email" => "james@onenie.com",
        "password" => "rapidfire23"},
      "name" => "",
      "username" => "BBI",
      "admin" => false,
      "verified" => true
    })
    Accounts.register_user(%{
      "credential" => %{
        "email" => "mike@onenie.com",
        "password" => "rapidfire23"},
      "name" => "",
      "username" => "BELL1",
      "admin" => false,
      "verified" => true
    })
  end

  def insert_ytd_sales() do
    "Sales By Vendor - YTD.csv"
    |> File.read!
    |> CSVParser.parse_string([{:skip_headers, false}]) |>
    Enum.map(fn [a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x] -> 
      parts = h |> String.split(" -- ")
      h = parts |> Enum.at(0)
      h2 = parts |> Enum.at(1)
      SalesByVendor.create(%{a: a, b: b, c: c, d: d, e: e, f: f, g: g, h: h, h2: h2, i: i, j: j, k: k, l: l, m: m, n: n, o: o, p: p, q: q, r: r, s: s, t: t, u: u, v: v, w: w, x: x})
    end)
  end

  def main() do
    CsvDb.insert_ytd_sales()
  end

end

CsvDb.create_users()
CsvDb.main()