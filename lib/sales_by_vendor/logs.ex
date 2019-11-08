defmodule SalesByVendor.Logs do
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias SalesByVendor.Repo
  alias SalesByVendor.Logs.Log

  def create_log(params) do
    changeset = Log.changeset(%Log{}, params)
    case Repo.insert(changeset) do
      {:ok, log} ->
        {:ok, %{id: log.id}}
      {:error, changeset} ->
        reason = Repo.traverse_error(changeset)
        {:error, reason}
    end
  end

  def get_logs(:type, type) do
    q = 
      from x in Log, 
      where: x.type == ^type, 
      order_by: x.inserted_at 
    logs = Repo.all(q)
    logs = Enum.map(logs, fn log ->
      log
      |> Map.delete(:__meta__)
      |> Map.delete(:__struct__)
    end)
    %{logs: logs}
  end

end