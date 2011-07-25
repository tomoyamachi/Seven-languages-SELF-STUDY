class NilClass
  def blank?
    false
  end
end
class String
  def blank?
    self.size == 0
  end
end
["" , "person" , nil].each do |element|
  puts element unless element.blank?
end
class Numeric
  def inches
    self
  end
  def feet
    self * 12.inches
  end
  def yards
    self * 3.feet
  end
  def miles
    self * 5280.feet
  end
  def back
    self * -1
  end
  def forward
    self
  end
end
puts 10.miles.back
puts 2.feet.forward

class Roman
  def self.method_missing name, *args
  roman = name.to_s
  roman.gsub!("IV" , "IIII" )
  roman.gsub!("IX" , "VIIII" )
  roman.gsub!("XL" , "XXXX" )
  roman.gsub!("XC" , "LXXXX" )
  (roman.count("I" ) +
   roman.count("V" ) * 5 +
   roman.count("X" ) * 10+
   roman.count("L" ) * 50+
   roman.count("C" ) *100)
  end
end
puts Roman.X
puts Roman.XC
puts Roman.XII
puts Roman.X
puts Roman.test


# sample_txt = open("rubycsv.txt", "w")
# test_arry = ["ukon","ukno"] * 10
# test_arry << "unko"
# 10.times{ sample_txt.puts test_arry.join(",") }
# sample_txt.close

module ActsAsCsv
  def self.included base
    base.extend ClassMethods
  end
  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end
  module InstanceMethods
    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ' )
      file.each do |row|
        @csv_contents << row.chomp.split(', ' )
      end
    end
    attr_accessor :headers, :csv_contents
    def initialize
      read
    end
  end
end
class RubyCsv
  include ActsAsCsv
  acts_as_csv
  def each(&block)
    a=[]
    self.csv_contents.each do |content|
      a << block.call(RowCsv.new(self.headers,content))
    end
    return a
  end
end
class RowCsv
  def initialize(headers, content)
    @headers = headers
    @content = content
  end
  def method_missing(row_name, *arg)
    if @headers.member?(row_name.to_s)
      header_index = @headers.index(row_name.to_s)
      @content[header_index]
    else
      raise NoMethodError.new("method missing! #{row_name}")
    end
  end
end
rc = RubyCsv.new
puts rc.headers.inspect
puts rc.csv_contents.inspect
rc.each{|row| puts row.one }


