alias NimbleCSV.RFC4180, as: CSVParser

defmodule H do

  

  NimbleCsv.define(MyParser, separator: "\t", escape: "\"")

  def p() do
    MyParser.parse_string "name\tage\njon\t27"
  end

end