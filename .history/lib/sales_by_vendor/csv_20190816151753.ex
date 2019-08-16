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
    
  end

end