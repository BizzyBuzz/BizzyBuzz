alias SalesByVendor.{SalesByVendor, Functions}

defmodule YearCorrectionDb do

  def yy_to_yyyy() do
    sales_by_vendors = SalesByVendor.get_all()
    Enum.each(sales_by_vendors, fn sales_by_vendor ->
      id = sales_by_vendor.id
      col = sales_by_vendor.b
      if !is_nil(col) do 
        [month, day, year] = String.split(col, "/")
        day = 
          if String.length(day) == 2 do
            month
          else
            month = "0#{day}" 
          end
        year = 
          if String.length(year) == 4 do
            year
          else
            year = "20#{year}"
          end
        col = "#{month}/#{day}/#{year}"
        SalesByVendor.update(:id, %{id: id, b: col}) |> IO.inspect
      end
    end)

    Enum.each(sales_by_vendors, fn sales_by_vendor ->
      id = sales_by_vendor.id
      col = sales_by_vendor.j
      if !is_nil(col) do 
        [month, day, year] = String.split(col, "/")
        day = 
          if String.length(day) == 2 do
            month
          else
            month = "0#{day}" 
          end
        year = 
          if String.length(year) == 4 do
            year
          else
            year = "20#{year}"
          end
        col = "#{month}/#{day}/#{year}"
        SalesByVendor.update(:id, %{id: id, j: col}) |> IO.inspect
      end
    end)

  end

end

YearCorrectionDb.yy_to_yyyy()

# sales_by_vendor
# l = String.length(col)
# last_four_chars = String.slice(col, l-4..l)
# try do
#   String.to_integer(last_four_chars) # 11/19/2019
# rescue 
#   ArgumentError -> 
#     id = sales_by_vendor.id
#     last_two_chars = String.slice(col, l-2..l) # "11/19/19"
#     without_year = String.slice(col, 0..l-3)
#     with_full_year = "#{without_year}20#{last_two_chars}" # "11/19/2019"
#     SalesByVendor.update(:id, %{id: id, b: with_full_year}) |> IO.inspect
# end