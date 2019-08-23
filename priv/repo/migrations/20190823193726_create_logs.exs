defmodule SalesByVendor.Repo.Migrations.CreateLogs do
  use Ecto.Migration

  def change do
    create table(:logs) do
      add :type, :string # admin
      add :status, :string # 200
      add :desc, :string # filename: Sales By Vendor - Prior Day.csv
      timestamps()
    end
  end
end
