defmodule SalesByVendorWeb.PageController do
  use SalesByVendorWeb, :controller

  alias SalesByVendor.SalesByVendor

  plug :authenticate

  def dashboard(conn, _params) do
    render(conn, "dashboard.html")
  end

  def index(conn, params) do
    id = params["id"]
    sales_by_vendors = SalesByVendor.get_all(:id, id)

    render(conn, "index.html", sales_by_vendors)
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

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.session_path(conn, :new))
      |> halt()
    end
  end

end
