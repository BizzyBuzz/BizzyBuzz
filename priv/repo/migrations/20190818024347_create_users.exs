defmodule SalesByVendor.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :username, :string, null: false
      add :admin, :boolean, default: false
      add :deactivated, :boolean, default: false
      add :reset_password_token, :string
      add :reset_token_sent_at, :naive_datetime
      add :verified, :boolean, default: false
      timestamps()
    end
  
    create unique_index(:users, [:username])
  end

end