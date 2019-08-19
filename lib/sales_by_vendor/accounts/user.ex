defmodule SalesByVendor.Accounts.User do 
  use Ecto.Schema
  import Ecto.Changeset

  alias SalesByVendor.Accounts.Credential
  alias SalesByVendor.Vendors
  
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
    |> validate_required([:username])
    # |> validate_required([:name, :username])
    |> validate_length(:username, min: 1, max: 20)
  end

  def registration_changeset(user, params) do 
    username = params["username"]
    email = params["credential"]["email"]
    vendor = Vendors.get_vendor(%{username: username, email: email})
    if vendor do
      user
      |> changeset(params)
      |> unique_constraint(:username)
      |> cast_assoc(:credential, with: &Credential.changeset/2, required: true) 
    else
      user
      |> changeset(params)
      |> add_error(:username, "Vendor does not exist or email does not match vendor email")
    end
  end

  def password_token_changeset(user, params) do
    cast(user, params, [:reset_password_token, :reset_token_sent_at])
  end

end