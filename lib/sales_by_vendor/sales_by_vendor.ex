defmodule SalesByVendor.SalesByVendor do
  import Ecto.Changeset
  import Ecto.Query
  
  alias SalesByVendor.Repo
  alias SalesByVendor.SalesByVendor.SalesByVendor

  def create(params) do
    changeset = SalesByVendor.changeset(%SalesByVendor{}, params)
    case Repo.insert(changeset) do
      {:ok, sales_by_vendor} ->
        {:ok, %{id: sales_by_vendor.id}}
      {:error, changeset} ->
        reason = Repo.traverse_error(changeset)
        {:error, reason}
    end
  end

  def get_dtd(date, username) do
    q = 
      from x in SalesByVendor, 
      where: x.i == ^date
      and x.h == ^username
    sales_by_vendors = Repo.all(q)
    sales_by_vendors = Enum.map(sales_by_vendors, fn sales_by_vendor ->
      sales_by_vendor
      |> Map.delete(:__meta__)
      |> Map.delete(:__struct__)
    end)
    %{sales_by_vendors: sales_by_vendors}
  end

  def get_mtd(m, yyyy, username) do
    IO.inspect username
    regex = "^#{m}\/[0-9][0-9]*\/#{yyyy}"
    q = 
      from x in SalesByVendor, 
      where: fragment("? ~ ?", x.i, ^regex)
      and x.h == ^username
    sales_by_vendors = Repo.all(q)
    sales_by_vendors = Enum.map(sales_by_vendors, fn sales_by_vendor ->
      sales_by_vendor
      |> Map.delete(:__meta__)
      |> Map.delete(:__struct__)
    end)
    %{sales_by_vendors: sales_by_vendors}
  end

  def get_ytd(yyyy, username) do
    q = 
      from x in SalesByVendor, 
      where: like(x.i, ^"%#{yyyy}")
      and x.h == ^username
    sales_by_vendors = Repo.all(q)
    sales_by_vendors = Enum.map(sales_by_vendors, fn sales_by_vendor ->
      sales_by_vendor
      |> Map.delete(:__meta__)
      |> Map.delete(:__struct__)
    end)
    %{sales_by_vendors: sales_by_vendors}
  end

  def get_all(:id, id) do
    q = 
      from x in SalesByVendor, 
      where: x.h == ^id
    sales_by_vendors = Repo.all(q)
    sales_by_vendors = Enum.map(sales_by_vendors, fn sales_by_vendor ->
      sales_by_vendor
      |> Map.delete(:__meta__)
      |> Map.delete(:__struct__)
    end)
    %{sales_by_vendors: sales_by_vendors}
  end

  def insert(row) do
    a = row |> Enum.at(0)
    b = row |> Enum.at(1)
    c = row |> Enum.at(2)
    d = row |> Enum.at(3)
    e = row |> Enum.at(4)
    f = row |> Enum.at(5) 
    g = row |> Enum.at(6)
    h = row |> Enum.at(7)
    h2 = row |> Enum.at(8)
    i = row |> Enum.at(9)
    j = row |> Enum.at(10)
    k = row |> Enum.at(11)
    l = row |> Enum.at(12)
    m = row |> Enum.at(13)
    n = row |> Enum.at(14)
    o = row |> Enum.at(15)
    p = row |> Enum.at(16)
    q = row |> Enum.at(17)
    r = row |> Enum.at(18)
    s = row |> Enum.at(19)
    t = row |> Enum.at(20)
    u = row |> Enum.at(21)
    v = row |> Enum.at(22)
    w = row |> Enum.at(23)
    x = row |> Enum.at(24)
    create(%{a: a, b: b, c: c, d: d, e: e, f: f, g: g, h: h, h2: h2, i: i, j: j, k: k, l: l, m: m, n: n, o: o, p: p, q: q, r: r, s: s, t: t, u: u, v: v, w: w, x: x})
  end

end