alias NimbleCSV.RFC4180, as: CSVParser

defmodule Csv do
  alias SalesByVendor.SalesByVendor

  def insert_new_sales(file_binary) do
    csv = 
      file_binary
      |> String.split("\r\n")

    Enum.each csv, fn row -> 
      row = String.replace(row, ~r/\",/, "†", global: true) # \", †
      row = String.replace(row, ~r/,\"/, "†", global: true) # ,\", †
      row = String.replace(row, ~r/\"/, "", global: true) # \" ""
      cols = String.split(row, "†")
 
      row = 
        for i <- 0..length(cols) - 1 do
          col = cols |> Enum.at(i)
          cond do
            i == 7 -> 
              parts = col |> String.split(" -- ")) 
            i == 12 || i == 14 || i == 16 || i == 18 ->
              parts = col |> String.split(",")
            true - >
              col
          end
        end
        
      row = row |> List.flatten

      # write this to the database
      SalesByVendor.insert(row)
    end

    # csv = 
    #   for i <- 0..length(csv) - 1 do
    #     row = Enum.at(csv, i)
    #     row = String.replace(row, ~r/\\/, "", global: true)
    #     row = String.replace(row, ~r/\"/, "", global: true) 
    #     cols = String.split(row, ",") # ["14365", "Wedding", ...]
    #   end

    # IO.inspect csv

    # Enum.map(csv, fn [a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x] ->
    #   IO.inspect a
    #   IO.inspect b
    #   IO.inspect c
    #   IO.inspect d
    #   IO.inspect e
    #   IO.inspect f
    #   IO.inspect g
    #   IO.inspect h
    #   IO.inspect i
    #   IO.inspect j
    #   IO.inspect k
    #   IO.inspect l
    #   IO.inspect m
    #   IO.inspect n
    #   IO.inspect o
    #   IO.inspect p
    #   IO.inspect q
    #   IO.inspect r
    #   IO.inspect s
    #   IO.inspect t
    #   IO.inspect u
    #   IO.inspect v
    #   IO.inspect w
    #   IO.inspect x
    # end)

    # |> File.read! |> CSVParser.parse_string |>
    # csv |> 
    #   Enum.map(fn [a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x] ->
    #     IO.inspect a
    #   end)
    
  end

end