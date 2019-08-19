defmodule SalesByVendor.Functions do
  
  def random_string(length) do
    # generate random key, such as API key
    length
    |> :crypto.strong_rand_bytes
    |> Base.url_encode64
    |> binary_part(0, length)
  end

end