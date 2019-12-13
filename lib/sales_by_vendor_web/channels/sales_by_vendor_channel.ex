defmodule SalesByVendorWeb.SalesByVendorChannel do
  use SalesByVendorWeb, :channel

  alias SalesByVendor.ApiForChannel

  def join("sales_by_vendor:" <> subtopic, _message, socket) do 
    case (socket |> assign(:subtopic_pid, ApiForChannel.new())) do
      socket ->
        {:ok, socket}
      _ ->
        {:error, %{reason: "cannot join channel"}, socket}
    end
  end

  def handle_info(:stop_sales_by_vendor, socket) do
    {:stop, :normal, socket}
  end

  def handle_in("calculate_commission", payload, socket) do
    %{"commission_rate" => commission_rate, "grand_total" => grand_total} = payload
    commission = socket.assigns.subtopic_pid |> ApiForChannel.calculate_commission(commission_rate, grand_total)
    push(socket, "calculate_commission", commission)
    {:reply, {:ok, commission}, socket}
  end

end