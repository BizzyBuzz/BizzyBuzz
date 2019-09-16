defmodule SalesByVendor.Functions do

  alias NimbleCSV.RFC4180, as: CSVParser
  
  def create_timestamp() do
    {date, time} = :calendar.local_time()
    {:ok, date_elixir} = Date.from_erl(date)
    {:ok, time_elixir} = Time.from_erl(time)
    {:ok, time_stamp} = NaiveDateTime.new(date_elixir, time_elixir)
    to_string(time_stamp)
  end

  def local_to_utc_date_time(local_date_time) do # local_date_time = :calendar.local_time() -> {{2019, 2, 15}, {11, 34, 15}}
    [{utc_date, utc_time}] = local_date_time |> :calendar.local_time_to_universal_time_dst()
    {:ok, utc_date_elixir} = Date.from_erl(utc_date) # {:ok, ~D[2019-05-24]}
    {:ok, utc_time_elixir} = Time.from_erl(utc_time) # {:ok, ~T[19:00:00]}
    NaiveDateTime.new(utc_date_elixir, utc_time_elixir) # {:ok, ~N[2019-05-24 19:00:00]}
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

  def to_elixir_date(date) do # "03-06-2019" => {:ok, ~N[2019-03-06 00:00:00]}
    date = String.split(date, "-") # split date by "-"
    date = 
      Enum.map(date, fn d -> # convert date parts to ints
        String.to_integer(d)
      end)
    month = date |> Enum.at(0)
    day = date |> Enum.at(1)
    year = date |> Enum.at(2)
    [{date, time}] = [{{year, month, day}, {0, 0, 0}}]
    {:ok, date} = Date.from_erl(date)
    {:ok, time} = Time.from_erl(time)
    NaiveDateTime.new(date, time)
  end

  def to_elixir_date_time(start_at) do # "2019-03-06 13:30:00" -> {:ok, ~N[2019-03-06 13:30:30]}
    date_time_parts = String.split(start_at, " ")
    date_parts = date_time_parts |> Enum.at(0)
    time_parts = date_time_parts |> Enum.at(1)
    date = String.split(date_parts, "-") # split date by "-"
    date = # convert date parts to ints
      Enum.map(date, fn d -> 
        String.to_integer(d)
      end)
    time = String.split(time_parts, ":") # split time by : 
    time = # convert time parts to ints
      Enum.map(time, fn t ->  
        String.to_integer(t)
      end)
    # assemble parts into elixir/erlang date time
    year = date |> Enum.at(0)
    month = date |> Enum.at(1)
    day = date |> Enum.at(2)
    hour = time |> Enum.at(0)
    min = time |> Enum.at(1)
    sec = time |> Enum.at(1)
    [{date, time}] = [{{year, month, day}, {hour, min, sec}}]
    {:ok, date} = Date.from_erl(date)
    {:ok, time} = Time.from_erl(time)
    NaiveDateTime.new(date, time) # {:ok, ~N[2019-03-06 13:30:30]}
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