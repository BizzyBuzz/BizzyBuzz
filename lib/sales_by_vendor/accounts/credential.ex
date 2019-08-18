defmodule SalesByVendor.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset

  schema "credentials" do
    field :email, :string
    field :password, :string, virtual: true 
    field :password_hash, :string 
    belongs_to :user, SalesByVendor.Accounts.User
    timestamps()
  end
  
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_length(:password, min: 6, max: 100) |> unique_constraint(:email)
    |> put_pass_hash()
  end

  def email_changeset(credential, params) do
    cast(credential, params, [:email])
  end

  defp put_pass_hash(changeset) do 
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} -> 
        put_change(changeset, :password_hash, Comeonin.Pbkdf2.hashpwsalt(pass))
      _ ->
        changeset
    end 
  end

  def password_changeset(credential, params \\ %{}) do
    cast(credential, params, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 100)
    |> validate_confirmation(:password)
    |> put_pass_hash()
  end

end