alias NimbleCSV.RFC4180, as: CSVParser

# NimbleCsv.define(MyParser, separator: "\t", escape: "\"")

defmodule H do

  def f() do
    # a = ["a", "b"]
    # b = a ++ ["c", "d"]
    # IO.puts a
    a = ["a", "b"]
    b = ["c", "d"]
    c = a ++ b
    # a = ["a", "b"] ++ ["c", "d"]
    IO.inspect c
  end

  def p() do
    sales = [
      "\"Vendor Sales\",7/12/2019,\"Vendor Part Num\",\"Item #\",\"Item Name\",\"Quantity\",\"Ext Price\",\"1450GBJ1 -- 1450 Glass by Janet\",\"7/11/2019\",\"1535\",\"1535\",\"Dish 5\"\" Glass MI Blue\",1.00,$19.20,\"7/11/2019\",2.00,$24.20,\"1450GBJ1 -- 1450 Glass by Janet\",2.00,$24.20,\"Grand Totals:\",118.00,$1869.36,1",
      "\"Vendor Sales\",7/12/2019,\"Vendor Part Num\",\"Item #\",\"Item Name\",\"Quantity\",\"Ext Price\",\"1450GBJ1 -- 1450 Glass by Janet\",\"7/11/2019\",\"3519\",\"3519\",\"Magnet Glass Small\",1.00,$5.00,\"7/11/2019\",2.00,$24.20,\"1450GBJ1 -- 1450 Glass by Janet\",2.00,$24.20,\"Grand Totals:\",118.00,$1869.36,1",
      "\"Vendor Sales\",7/12/2019,\"Vendor Part Num\",\"Item #\",\"Item Name\",\"Quantity\",\"Ext Price\",\"321SC1 -- 321 Simple Creations, LLC\",\"7/11/2019\",\"1047\",\"1047\",\"Earring Sterling Silver 36\",1.00,$36.00,\"7/11/2019\",3.00,$66.00,\"321SC1 -- 321 Simple Creations, LLC\",3.00,$66.00,\"Grand Totals:\",118.00,$1869.36,1"
    ]
    row = "\"Vendor Sales\",7/12/2019,\"Vendor Part Num\",\"Item #\",\"Item Name\",\"Quantity\",\"Ext Price\",\"321SC1 -- 321 Simple Creations, LLC\",\"7/11/2019\",\"1047\",\"1047\",\"Earring Sterling Silver 36\",1.00,$36.00,\"7/11/2019\",3.00,$66.00,\"321SC1 -- 321 Simple Creations, LLC\",3.00,$66.00,\"Grand Totals:\",118.00,$1869.36,1"    
    row = String.replace(row, ~r/\",/, "†", global: true) # \", †
    row = String.replace(row, ~r/,\"/, "†", global: true) # ,\", †
    row = String.replace(row, ~r/\"/, "", global: true) # \" ""
    cols = String.split(row, "†")

    # rewrite 
    csv = 
      for i <- 1..length(cols) - 1 do
        col = cols |> Enum.at(i)
        if i == 12 || i == 14 || i == 16 || i == 18 do
          parts = col |> String.split(",")
        else
          col
        end
      end
    csv = csv |> List.flatten

    csv = 
      csv 
      |> Enum.at(0)
      |> CSVParser.parse_string
      |> Enum.map(fn [a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x] ->
           IO.inspect a
         end)
    IO.inspect csv
  end

end