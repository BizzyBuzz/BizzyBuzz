defmodule SalesByVendor.Server do

  alias SalesByVendor.Functions

  # call start_link() upon restart and restart child processes only if they crash
  use GenServer, start: {__MODULE__, :start_link, []}, restart: :transient

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(state), do: {:ok, state}

  def handle_call({:calculate_commission, commission_rate, grand_total}, _from, state) do
    commission = Functions.calculate_commission(commission_rate, grand_total)
    {:reply, %{commission: commission}, state}
  end

end