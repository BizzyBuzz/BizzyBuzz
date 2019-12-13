defmodule SalesByVendor.ApiForChannel do

  def new() do
    {:ok, pid} = SalesByVendor.Server.start_link()
    pid
  end

  def calculate_commission(pid, commission_rate, grand_total) do
    GenServer.call(pid, {:calculate_commission, commission_rate, grand_total})
  end
  
end
