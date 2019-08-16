defmodule SalesByVendorWeb.PageController do
  use SalesByVendorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def insert_new_sales(conn, params) do
    file = params["file"]
    filename = file.filename
    path = file.path
    {:ok, file_binary} = File.read(path)
    # IO.inspect "XXXXXXXXXXXXXX"
    # IO.inspect file_binary
    # IO.inspect "XXXXXXXXXXXXXX"

    Csv.insert_new_sales(file_binary)

    # csv_filename = "#{Bcs.Functions.create_timestamp()}.csv"
    # {:ok, file} = File.open("hello", [:write])
    # IO.binwrite(file, "world")
    # File.close(file)

    conn
    # |> put_flash(:success, "File uploaded successfully!")
    |> json(%{filename: filename})
  end

end
