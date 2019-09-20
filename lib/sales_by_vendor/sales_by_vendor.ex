defmodule SalesByVendor.SalesByVendor do
  import Ecto.Changeset
  import Ecto.Query

  alias SalesByVendor.Functions
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

  def get_all(:id, id) do
    q = 
      from x in SalesByVendor, 
      where: x.k == ^id
    sales_by_vendors = Repo.all(q)
    sales_by_vendors = Enum.map(sales_by_vendors, fn sales_by_vendor ->
      sales_by_vendor
      |> Map.delete(:__meta__)
      |> Map.delete(:__struct__)
    end)
    %{sales_by_vendors: sales_by_vendors}
  end

  def get_dtd(username, client_now_utc) do
    # convert client_now_utc to elixir
    {:ok, client_now_utc} = Functions.to_elixir_date_time(client_now_utc)
    
    yesterday = client_now_utc |> Timex.shift(days: -1) # ~U[2019-09-13 19:02:07.627417Z]
    m = yesterday.month
    d = yesterday.day 
    yyyy = yesterday.year

    q = 
      from x in SalesByVendor, 
      where: fragment("date_part('month', ?)", x.inserted_at) == ^m
      and fragment("date_part('day', ?)", x.inserted_at) >= ^d
      and fragment("date_part('year', ?)", x.inserted_at) == ^yyyy
      and x.k == ^username
    sales_by_vendors = Repo.all(q)

    sales_by_vendors = Enum.map(sales_by_vendors, fn sales_by_vendor ->
      sales_by_vendor
      |> Map.delete(:__meta__)
      |> Map.delete(:__struct__)
    end)
  end

  def get_all_vendors_dtd(client_now_utc) do 
    # convert client_now_utc to elixir
    {:ok, client_now_utc} = Functions.to_elixir_date_time(client_now_utc)

    yesterday = client_now_utc |> Timex.shift(days: -1)
    m = yesterday.month
    d = yesterday.day 
    yyyy = yesterday.year
    
    q = 
      from x in SalesByVendor, 
      where: fragment("date_part('month', ?)", x.inserted_at) == ^m
      and fragment("date_part('day', ?)", x.inserted_at) >= ^d
      and fragment("date_part('year', ?)", x.inserted_at) == ^yyyy, 
      order_by: fragment("lower(?) ASC", x.k2)
    sales_by_vendors = Repo.all(q)

    sales_by_vendors = Enum.map(sales_by_vendors, fn sales_by_vendor ->
      sales_by_vendor
      |> Map.delete(:__meta__)
      |> Map.delete(:__struct__)
    end)
  end

  def get_wtd(username, client_week_start_utc, client_week_end_utc) do
    {:ok, client_week_start_utc} = Functions.to_elixir_date_time(client_week_start_utc)
    {:ok, client_week_end_utc} = Functions.to_elixir_date_time(client_week_end_utc)
    
    q = 
      from x in SalesByVendor, 
      where: x.inserted_at >= ^client_week_start_utc
      and x.inserted_at <= ^client_week_end_utc
      and x.k == ^username
    sales_by_vendors = Repo.all(q)

    sales_by_vendors = Enum.map(sales_by_vendors, fn sales_by_vendor ->
      sales_by_vendor
      |> Map.delete(:__meta__)
      |> Map.delete(:__struct__)
    end)
  end

  def get_all_vendors_wtd(client_week_start_utc, client_week_end_utc) do 
    # convert to elixir, # "2019-9-16 22:07:02" -> {:ok, ~N[2019-09-16 22:07:07]}
    {:ok, client_week_start_utc} = Functions.to_elixir_date_time(client_week_start_utc)
    {:ok, client_week_end_utc} = Functions.to_elixir_date_time(client_week_end_utc)
    
    q = 
      from x in SalesByVendor,
      where: x.inserted_at >= ^client_week_start_utc
      and x.inserted_at <= ^client_week_end_utc
    sales_by_vendors = Repo.all(q)
    
    sales_by_vendors = Enum.map(sales_by_vendors, fn sales_by_vendor ->
      sales_by_vendor
      |> Map.delete(:__meta__)
      |> Map.delete(:__struct__)
    end)
  end

  def get_mtd(username, client_month_start_utc, client_month_end_utc) do
    {:ok, client_month_start_utc} = Functions.to_elixir_date_time(client_month_start_utc)
    {:ok, client_month_end_utc} = Functions.to_elixir_date_time(client_month_end_utc)

    q = 
      from x in SalesByVendor, 
      where: x.inserted_at >= ^client_month_start_utc
      and x.inserted_at <= ^client_month_end_utc
      # where: fragment("date_part('month', ?)", x.inserted_at) == ^m
      # and fragment("date_part('year', ?)", x.inserted_at) == ^yyyy 
      and x.k == ^username
    sales_by_vendors = Repo.all(q)

    sales_by_vendors = Enum.map(sales_by_vendors, fn sales_by_vendor ->
      sales_by_vendor
      |> Map.delete(:__meta__)
      |> Map.delete(:__struct__)
    end)
  end

  def get_all_vendors_mtd(client_month_start_utc, client_month_end_utc) do
    {:ok, client_month_start_utc} = Functions.to_elixir_date_time(client_month_start_utc)
    {:ok, client_month_end_utc} = Functions.to_elixir_date_time(client_month_end_utc)

    q = 
      from x in SalesByVendor, 
      where: x.inserted_at >= ^client_month_start_utc
      and x.inserted_at <= ^client_month_end_utc
      # where: fragment("date_part('month', ?)", x.inserted_at) == ^m
      # and fragment("date_part('year', ?)", x.inserted_at) == ^yyyy
    sales_by_vendors = Repo.all(q)
    
    sales_by_vendors = Enum.map(sales_by_vendors, fn sales_by_vendor ->
      sales_by_vendor
      |> Map.delete(:__meta__)
      |> Map.delete(:__struct__)
    end)
  end

  def calc_total(all_vendors, column) do
    total = 
      Enum.reduce(all_vendors, 0, fn vendor, acc ->  
        if vendor[column] do
          amount = 
            vendor[column] 
            |> String.replace("$", "") 
            |> String.replace(",", "")
            |> String.replace(" ", "") 
            |> Decimal.new()
          Decimal.add(amount, acc)
        else
          acc
        end
      end)
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
    i = row |> Enum.at(8)
    j = row |> Enum.at(9)
    k = row |> Enum.at(10)
    k2 = row |> Enum.at(11)
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
    y = row |> Enum.at(25)
    z = row |> Enum.at(26)
    aa = row |> Enum.at(27)
    bb = row |> Enum.at(28)
    cc = row |> Enum.at(29)
    dd = row |> Enum.at(30)
    ee = row |> Enum.at(31)
    ff = row |> Enum.at(32)
    gg = row |> Enum.at(33)
    hh = row |> Enum.at(34)
    create(%{a: a, b: b, c: c, d: d, e: e, f: f, g: g, h: h, i: i, j: j, k: k, k2: k2, l: l, m: m, n: n, o: o, p: p, q: q, r: r, s: s, t: t, u: u, v: v, w: w, x: x, y: y, z: z, aa: aa, bb: bb, cc: cc, dd: dd, ee: ee, ff: ff, gg: gg, hh: hh})
  end

end

# def get_ytd(username) do
#   yyyy = Functions.now_year_in_utc()
#   q = 
#     from x in SalesByVendor, 
#     where: fragment("date_part('year', ?)", x.inserted_at) == ^yyyy 
#     # where: like(x.i, ^"%#{yyyy}")
#     and x.h == ^username
#   sales_by_vendors = Repo.all(q)
#   sales_by_vendors = Enum.map(sales_by_vendors, fn sales_by_vendor ->
#     sales_by_vendor
#     |> Map.delete(:__meta__)
#     |> Map.delete(:__struct__)
#   end)
# end

# def get_all_vendors_ytd() do
#   yyyy = Functions.now_year_in_utc()
#   q = 
#     from x in SalesByVendor, 
#     where: fragment("date_part('year', ?)", x.inserted_at) == ^yyyy, 
#     order_by: fragment("lower(?) ASC", x.h2)
#   sales_by_vendors = Repo.all(q)
#   sales_by_vendors = Enum.map(sales_by_vendors, fn sales_by_vendor ->
#     sales_by_vendor
#     |> Map.delete(:__meta__)
#     |> Map.delete(:__struct__)
#   end)
# end

# where: like(x.i, ^"%#{yyyy}"), 

# regex = "^#{m}\/[0-9][0-9]*\/#{yyyy}"
# where: fragment("? ~ ?", x.i, ^regex)

# regex = "^#{m}\/[0-9][0-9]*\/#{yyyy}"
# where: fragment("? ~ ?", x.inserted_at, ^regex)

# date_parts = String.split(date, "/")
# month = date_parts |> Enum.at(0) |> String.to_integer()
# day = date_parts |> Enum.at(1) |> String.to_integer()
# year = date_parts |> Enum.at(2) |> String.to_integer()

# def get_all_distinct_vendors() do
#   q = 
#     from(
#       x in SalesByVendor, 
#       distinct: true, 
#       select: x.h2, 
#       order_by: [x.h2]
#     )                            # comes back as array, 
#   sales_by_vendors = Repo.all(q) # don't need to take out __meta__ and __struct__
# end

#     day_of_week = Date.day_of_week client_now_utc
#     %{s: s, e: e} = Functions.mon_to_sun(day_of_week)
#     start_date_time = client_now_utc |> Timex.shift(days: -s)
#     end_date_time = client_now_utc