defmodule SalesByVendorWeb.VendorController do
  use SalesByVendorWeb, :controller

  alias SalesByVendor.Vendors
  alias SalesByVendor.Vendors.Vendor

  def index(conn, _params) do
    vendors = Vendors.list_vendors()
    render(conn, "index.html", vendors: vendors)
  end

  def new(conn, _params) do
    changeset = Vendors.change_vendor(%Vendor{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"vendor" => vendor_params}) do
    case Vendors.create_vendor(vendor_params) do
      {:ok, vendor} ->
        conn
        |> put_flash(:info, "Vendor created successfully.")
        |> redirect(to: Routes.vendor_path(conn, :show, vendor))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    vendor = Vendors.get_vendor!(id)
    render(conn, "show.html", vendor: vendor)
  end

  def edit(conn, %{"id" => id}) do
    vendor = Vendors.get_vendor!(id)
    changeset = Vendors.change_vendor(vendor)
    render(conn, "edit.html", vendor: vendor, changeset: changeset)
  end

  def update(conn, %{"id" => id, "vendor" => vendor_params}) do
    vendor = Vendors.get_vendor!(id)

    case Vendors.update_vendor(vendor, vendor_params) do
      {:ok, vendor} ->
        conn
        |> put_flash(:info, "Vendor updated successfully.")
        |> redirect(to: Routes.vendor_path(conn, :show, vendor))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", vendor: vendor, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    vendor = Vendors.get_vendor!(id)
    {:ok, _vendor} = Vendors.delete_vendor(vendor)

    conn
    |> put_flash(:info, "Vendor deleted successfully.")
    |> redirect(to: Routes.vendor_path(conn, :index))
  end
end
