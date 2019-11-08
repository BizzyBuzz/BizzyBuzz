alias NimbleCSV.RFC4180, as: CSVParser
alias SalesByVendor.{SalesByVendor, Accounts, Vendors, Functions}

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

  def insert_initial_sales() do
    "test 4 append.csv"
    |> File.read!
    |> CSVParser.parse_string([{:skip_headers, false}]) |>
    Enum.map(fn [a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z, aa, bb, cc, dd, ee, ff, gg, hh] -> 
      parts = i |> String.replace("VENDOR: ", "") |> String.split(" -- ")
      i = parts |> Enum.at(0)
      i2 = parts |> Enum.at(1)
      {:ok, %{id: id}} = SalesByVendor.create(%{a: a, b: b, c: c, d: d, e: e, f: f, g: g, h: h, i: i, i2: i2, j: j, k: k, l: l, m: m, n: n, o: o, p: p, q: q, r: r, s: s, t: t, u: u, v: v, w: w, x: x, y: y, z: z, aa: aa, bb: bb, cc: cc, dd: dd, ee: ee, ff: ff, gg: gg, hh: hh})
      {:ok, inserted_at} = Functions.to_elixir_naivedatetime(j)
      SalesByVendor.update(:id, %{id: id, inserted_at: inserted_at})
    end)
  end

  def main() do
    CsvDb.create_users()
    CsvDb.insert_initial_sales()
  end

end

CsvDb.main()