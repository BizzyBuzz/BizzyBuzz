defmodule SalesByVendor.SalesByVendor do
  import Ecto.Changeset
  import Ecto.Query
  
  alias SalesByVendor.Repo
  alias SalesByVendor.SalesByVendor.SalesByVendor

  def create(attrs \\ %{}) do
    %Persona{}
    |> Persona.changeset(attrs)
    |> Repo.insert()
  end

end