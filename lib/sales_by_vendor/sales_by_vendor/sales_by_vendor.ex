defmodule SalesByVendor.SalesByVendor.SalesByVendor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sales_by_vendors" do
    field(:a, :string)
    field(:b, :string)
    field(:c, :string)
    field(:d, :string)
    field(:e, :string)
    field(:f, :string)
    field(:g, :string)
    field(:h, :string)
    field(:i, :string)
    field(:i2, :string)
    field(:j, :string)
    field(:k, :string)
    field(:l, :string)
    field(:m, :string)
    field(:n, :string)
    field(:o, :string)
    field(:p, :string)
    field(:q, :string)
    field(:r, :string)
    field(:s, :string)
    field(:t, :string)
    field(:u, :string)
    field(:v, :string)
    field(:w, :string)
    field(:x, :string)
    field(:y, :string)
    field(:z, :string)
    field(:aa, :string)
    field(:bb, :string)
    field(:cc, :string)
    field(:dd, :string)
    field(:ee, :string)
    field(:ff, :string)
    field(:gg, :string)
    field(:hh, :string)
    timestamps()
  end

  def changeset(struct, attrs) do
    struct
    |> cast(attrs, [:a, :b, :c, :d, :e, :f, :g, :h, :i, :i2, :j, :k, :l, :m, :n, :o, :p, :q, :r, :s, :t, :u, :v, :w, :x, :y, :z, :aa, :bb, :cc, :dd, :ee, :ff, :gg, :hh])
  end

end