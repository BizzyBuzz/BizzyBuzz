defmodule SalesByVendor.Logs.Log do
  use Ecto.Schema
  import Ecto.Changeset

  schema "logs" do
    field :type, :string
    field :status, :string
    field :desc, :string

    timestamps()
  end

  def changeset(log, attrs) do
    log
    |> cast(attrs, [:type, :status, :desc])
    |> validate_required([:type, :desc])
  end

end