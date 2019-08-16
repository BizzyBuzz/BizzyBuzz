

defmodule H do

  alias NimbleCSV.RFC4180, as: CSVParser

NimbleCsv.define(MyParser, separator: "\t", escape: "\"")

  def p() do
    MyParser.parse_string "name\tage\njon\t27"
  end

end