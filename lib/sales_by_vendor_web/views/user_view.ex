defmodule SalesByVendorWeb.UserView do 
  use SalesByVendorWeb, :view
  alias SalesByVendor.Accounts

  def first_name(%Accounts.User{name: name}) do 
    name
    |> String.split(" ")
    |> Enum.at(0)
  end 

  def last_name(%Accounts.User{name: name}) do 
    name
    |> String.split(" ")
    |> Enum.at(1)
  end 

end