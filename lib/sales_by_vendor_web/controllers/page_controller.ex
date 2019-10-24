defmodule SalesByVendorWeb.PageController do
  use SalesByVendorWeb, :controller

  alias SalesByVendor.Functions
  alias SalesByVendor.Logs

  plug :authenticate when action not in [:dashboard, :insert_new_sales]

  def dashboard(conn, _params) do
    render(conn, "dashboard.html")
  end

  def index(conn, params) do
    id = params["id"]
    sales_by_vendors = SalesByVendor.SalesByVendor.get_all(:id, id)

    render(conn, "index.html", sales_by_vendors)
  end

  def insert_new_sales(conn, params) do
    api_key = params["apikey"]
    if api_key == System.get_env("BIZZ_API_KEY") do
      file = params["file"]
      if file do
        filename = file.filename
        path = file.path
        {:ok, file_binary} = File.read(path)

        csv = 
          file_binary
          |> String.split("\r\n")
        row = csv |> Enum.at(0)
        cols = String.split(row, ~r{,(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)})
        
        if length(cols) == 34 do # There should be exactly 34 columns in the CSV file
          Csv.insert_new_sales(file_binary)
          Logs.create_log(%{type: "admin", status: "200", desc: filename})
          conn
          |> put_status(200)
          |> json(%{filename: filename})
        else
          Logs.create_log(%{type: "admin", status: "422", desc: filename})
          conn
          |> put_status(422) # Unprocessable Entity
          |> json(%{error: "bad request"})
        end
      else
        conn
        |> put_status(400)
        |> json(%{error: "bad request"})
      end
    else
      Logs.create_log(%{type: "admin", status: "401", desc: "unauthorized"})
      conn 
      |> put_status(401)
      |> json(%{error: "unauthorized"})
    end
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
