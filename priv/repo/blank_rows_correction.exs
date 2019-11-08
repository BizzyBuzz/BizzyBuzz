alias SalesByVendor.{SalesByVendor, Functions}

defmodule BlankRowsCorrectionDb do

  def remove_blank_rows() do
    sales_by_vendors = SalesByVendor.get_blank_rows()
    Enum.each(sales_by_vendors, fn sales_by_vendor ->
      id = sales_by_vendor[:id]
      SalesByVendor.delete(:id, id) |> IO.inspect
    end)
  end

end

BlankRowsCorrectionDb.remove_blank_rows()