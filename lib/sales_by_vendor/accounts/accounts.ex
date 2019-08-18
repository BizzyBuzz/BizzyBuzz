defmodule SalesByVendor.Accounts do
  import Ecto.Changeset
  import Ecto.Query

  alias SalesByVendor.Accounts.User
  alias SalesByVendor.Accounts.Credential
  alias SalesByVendor.Repo

  def register_user(attrs \\ %{}) do 
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def create_user(attrs \\ %{}) do 
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def change_user(%User{} = user) do 
    User.changeset(user, %{})
  end

  def update_user(%{id: id, deactivated: deactivate}) do
    user = Repo.get_by(User, id: id)
    Repo.update(cast(user, %{deactivated: deactivate}, [:deactivated]))
  end

  def update_user(%{id: id, verified: verified}) do
    user = Repo.get_by(User, id: id)
    Repo.update(cast(user, %{verified: verified}, [:verified]))
  end
  
  def get_user2(id) do 
    user = Repo.get(User, id)
    if user != nil do
      user
      |> Map.delete(:__meta__)
      |> Map.delete(:__struct__)
      |> Map.delete(:credential)
    end
  end

  def get_user3(id) do
    from(u in User, join: c in assoc(u, :credential), where: u.id == ^id) 
    |> Repo.one()
    |> Repo.preload(:credential)
  end

  def get_user(id) do 
    Repo.get(User, id)
  end
  
  def get_user!(id) do 
    Repo.get!(User, id)
  end

  def get_user_by(params) do 
    Repo.get_by(User, params)
  end

  def get_users() do
    users = Repo.all(User) |> 
    Enum.map(fn user ->
      user
      |> Map.delete(:__meta__)
      |> Map.delete(:__struct__)
      |> Map.delete(:credential)
    end)
    %{users: users}
  end

  def list_users do 
    Repo.all(User)
  end

  def get_user_by_username(username) do
    q = from u in User, 
      where: u.username == ^username, 
      limit: 1,  
      preload: [:credential]
    Repo.one(q)
  end

  # def get_user_by_email(email) do
  #   from(u in User, join: c in assoc(u, :credential), where: c.email == ^email) 
  #   |> Repo.one()
  #   |> Repo.preload(:credential)
  # end

  def get_user_by_reset_password_token(reset_password_token) do
    from(u in User, where: u.reset_password_token == ^reset_password_token) 
    |> Repo.one()
    |> Repo.preload(:credential)
  end

  def authenticate_by_username_and_pass(username, given_pass) do
    user = get_user_by_username(username)
    cond do
      user && Comeonin.Pbkdf2.checkpw(given_pass, user.credential.password_hash) && !user.deactivated -> 
        {:ok, user}
      user ->
        {:error, :unauthorized}
      true -> 
        Comeonin.Bcrypt.dummy_checkpw() 
        {:error, :not_found}
    end 
  end

  # def authenticate_by_email_and_pass(email, given_pass) do
  #   user = get_user_by_email(email)
  #   cond do
  #     user && Comeonin.Pbkdf2.checkpw(given_pass, user.credential.password_hash) && !user.deactivated -> 
  #       {:ok, user}
  #     user ->
  #       {:error, :unauthorized}
  #     true -> 
  #       Comeonin.Bcrypt.dummy_checkpw() 
  #       {:error, :not_found}
  #   end 
  # end

  def list_credentials do
    Repo.all(Credential)
  end

  def get_credential!(id), do: Repo.get!(Credential, id)

  def create_credential(attrs \\ %{}) do
    %Credential{}
    |> Credential.changeset(attrs)
    |> Repo.insert()
  end

  def update_credential(%Credential{} = credential, attrs) do
    credential
    |> Credential.changeset(attrs)
    |> Repo.update()
  end

  def delete_credential(%Credential{} = credential) do
    Repo.delete(credential)
  end

  def change_credential(%Credential{} = credential) do
    Credential.changeset(credential, %{})
  end

  def mark_as_verified(user) do
    {ok, user} = update_user(%{id: user.id, verified: true})
  end

end