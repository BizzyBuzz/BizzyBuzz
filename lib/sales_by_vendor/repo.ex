defmodule SalesByVendor.Repo do
  use Ecto.Repo,
    otp_app: :sales_by_vendor,
    adapter: Ecto.Adapters.Postgres

  def traverse_error(changeset) do
    reason = Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} -> 
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value)) 
      end)
    end)
  end

end
