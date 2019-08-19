defmodule SalesByVendor.Repo.Migrations.CreateVendors do
  use Ecto.Migration

  def change do
    create table(:vendors) do
      add :name, :string
      add :email, :string

      timestamps()
    end

    create unique_index(:vendors, [:name], name: :vendors_name_index)
    create unique_index(:vendors, [:email], name: :vendors_email_index)
  end
end
