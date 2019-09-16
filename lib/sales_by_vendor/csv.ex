alias NimbleCSV.RFC4180, as: CSVParser

defmodule Csv do
  alias SalesByVendor.SalesByVendor

  require Logger

  def insert_new_sales(file_binary) do
    Logger.info DateTime.utc_now
    Logger.info file_binary
    csv = 
      file_binary
      |> String.split("\r\n")

    Enum.each csv, fn row -> 
      # columns containing columns come in surrounded by double quotes
      # regex split by comma not comma space
      cols = String.split(row, ~r{,(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)})

      row = 
        for i <- 0..length(cols) - 1 do
          col = cols |> Enum.at(i) |> String.replace(~r/\"/, "", global: true)
          cond do
            i == 10 -> 
              parts = col |> String.replace("VENDOR: ", "") |> String.split(" -- ")
            true ->
              col
          end
        end

      row = row |> List.flatten

      SalesByVendor.insert(row)
    end
    
  end

end

# FOR EVENTUAL GARBAGE COLLECTION

# ***ROWS***

# "Vendor Sales  Between 9/14/2019 and 9/14/2019 11:59:59 PM,9/14/19,Item Number,Description,Quantity,Revenue,Cost,Margin,Markup,\"Gross\n\nProfit\",VENDOR: 1450GBJ1 -- 1450 Glass by Janet,1527,\"6\"\" Dish Set - Golf\",1,$50.00 ,$0.00 ,100.00%,0.00%,$50.00 ,TOTAL FOR VENDOR:,1,$50.00 ,$0.00 ,100.00%,0.00%,$50.00 ,Grand Total:,93,\"$1,216.65 \",$45.25 ,96.28%,2688.73%,\"$1,171.40 \",1"

# "Vendor Sales  Between 9/14/2019 and 9/14/2019 11:59:59 PM,9/14/19,Item Number,Description,Quantity,Revenue,Cost,Margin,Markup,\"Gross\n\nProfit\",\"VENDOR: 321SC1 -- 321 Simple Creations, LLC\",2127,Earring SSlever Rd Michigan,1,$25.00 ,$0.00 ,100.00%,0.00%,$25.00 ,TOTAL FOR VENDOR:,1,$25.00 ,$0.00 ,100.00%,0.00%,$25.00 ,Grand Total:,93,\"$1,216.65 \",$45.25 ,96.28%,2688.73%,\"$1,171.40 \",1"

# ***CHUNKS***

# Vendor Sales  Between 9/14/2019 and 9/14/2019 11:59:59 PM,9/14/19,Item Number,Description,Quantity,Revenue,Cost,Margin,Markup,

# "Gross

# Profit",

# "VENDOR: 321SC1 -- 321 Simple Creations, LLC",

# 2127,Earring SSlever Rd Michigan,1,$25.00 ,$0.00 ,100.00%,0.00%,$25.00 ,TOTAL FOR VENDOR:,1,$25.00 ,$0.00 ,100.00%,0.00%,$25.00 ,Grand Total:,93,

# "$1,216.65 ",

# $45.25 ,96.28%,2688.73%,

# "$1,171.40 ",

# 1

# i == 7 -> 
#   parts = col |> String.split(" -- ")
# i == 12 || i == 14 || i == 16 || i == 18 ->
#   parts = col |> String.split(",")

# columns containing columns come in surrounded by double quotes
# so do this little routine to make chunks
# row = String.replace(row, ~r/\",/, "†", global: true)
# row = String.replace(row, ~r/,\"/, "†", global: true)
# row = String.replace(row, ~r/\"/, "", global: true)
# chunks = String.split(row, "†")

# IO.inspect chunks

# there will only be a few chunks at this point, the next loop does a second split and creates more columns
# row = 
#   for i <- 0..length(chunks) - 1 do
#     chunk = chunks |> Enum.at(i)
#     cond do
#       i == 2 -> 
#         IO.inspect chunk
#         parts = chunk |> String.split(" -- ")
#         part_1 = parts |> Enum.at(0)
#         part_2 = parts |> Enum.at(1)
#         part_2 = 
#           if !String.contains?(part_2, ",") || String.contains?(part_2, ", ") do
#             part_2 # don't split
#           else 
#             part_2 = part_2 |> String.split(",")
#           end
#         parts = [part_1] ++ [part_2]
#       i == 0 || i == 2 || i == 3 || i == 5 -> 
#         parts = chunk |> String.split(",")
#       true ->
#         chunk
#     end
#   end

# row = row |> List.flatten