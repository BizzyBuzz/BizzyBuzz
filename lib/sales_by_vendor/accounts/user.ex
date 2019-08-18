defmodule SalesByVendor.Accounts.User do 
  use Ecto.Schema
  import Ecto.Changeset

  alias SalesByVendor.Accounts.Credential
  
  schema "users" do
    field :name, :string
    field :username, :string
    field :admin, :boolean 
    field :deactivated, :boolean
    field :verified, :boolean
    field :reset_password_token, :string
    field :reset_token_sent_at, :naive_datetime
    has_one :credential, Credential
    timestamps()
  end

  def changeset(user, attrs) do 
    user
    |> cast(attrs, [:name, :username, :admin, :deactivated, :verified])
    |> validate_required([:name, :username])
    |> validate_length(:username, min: 1, max: 20)
  end

  def registration_changeset(user, params) do 
    user
    |> changeset(params)
    |> unique_constraint(:username)
    |> cast_assoc(:credential, with: &Credential.changeset/2, required: true) 
  end

  def password_token_changeset(user, params) do
    cast(user, params, [:reset_password_token, :reset_token_sent_at])
  end

end