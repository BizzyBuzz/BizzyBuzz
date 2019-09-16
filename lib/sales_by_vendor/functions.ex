defmodule SalesByVendor.Functions do

  alias NimbleCSV.RFC4180, as: CSVParser
  
  def create_timestamp() do
    {date, time} = :calendar.local_time()
    {:ok, date_elixir} = Date.from_erl(date)
    {:ok, time_elixir} = Time.from_erl(time)
    {:ok, time_stamp} = NaiveDateTime.new(date_elixir, time_elixir)
    to_string(time_stamp)
  end

  def mon_to_sun(day_of_week) do # mon_to_sun(7) -> %{s: 1, e: 7}
    %{s: s, e: e} = 
      case day_of_week do
        1 -> %{s: day_of_week, e: day_of_week}
        2 -> %{s: day_of_week - 1, e: day_of_week}
        3 -> %{s: day_of_week - 2, e: day_of_week}
        4 -> %{s: day_of_week - 3, e: day_of_week}
        5 -> %{s: day_of_week - 4, e: day_of_week}
        6 -> %{s: day_of_week - 5, e: day_of_week}
        7 -> %{s: day_of_week - 6, e: day_of_week}
      end 
  end

  def random_string(length) do
    # generate random key, such as an API key
    length
    |> :crypto.strong_rand_bytes
    |> Base.url_encode64
    |> binary_part(0, length)
  end

  def to_csv(data) do
    data
    |> CSVParser.dump_to_iodata()
  end

end

# def now_month_in_utc() do
#   now = :calendar.local_time()                               # {{2019, 3, 28}, {12, 30, 30}}
#   now_utc = :calendar.local_time_to_universal_time_dst(now)  # [{{2019, 3, 28}, {16, 30, 30}}]
#   {{_, month, _}, _} = now_utc |> Enum.at(0)
#   month
# end

# def now_day_in_utc() do
#   now = :calendar.local_time()
#   now_utc = :calendar.local_time_to_universal_time_dst(now)
#   {{_, _, day}, _} = now_utc |> Enum.at(0)
#   day
# end

# def now_year_in_utc() do
#   now = :calendar.local_time()
#   now_utc = :calendar.local_time_to_universal_time_dst(now)
#   {{year, _, _}, _} = now_utc |> Enum.at(0)
#   year
# end