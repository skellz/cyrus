require 'pry'
require 'date'

class CyrusReader
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def get_file_contents
    data = {:LastName => [], :FirstName => [], :Gender => [], :FavoriteColor => [], :DateOfBirth => []}
    File.open(@filename) do |file|
      file.each do |line|
        
        if line.include?(", ") 
          info = line.split(", ")
          data[:Gender] << info[2]                  
          data[:FavoriteColor] << info[3]
          data[:DateOfBirth] << info[4].tr("\n", '')          
        elsif line.include?(" | ")
          info = line.split(" | ")
          data[:Gender] << set_gender(info[3])
          data[:DateOfBirth] << set_date(info[5].tr("\n", ''))
          data[:FavoriteColor] << info[4]
        else
          info = line.split(" ")
          data[:Gender] << set_gender(info[3])
          data[:DateOfBirth] << set_date(info[4].tr("\n", ''))
          data[:FavoriteColor] << info[5]
        end

        data[:LastName] << info[0]
        data[:FirstName] << info[1]
        
      end
    end
    data
  end

  def set_gender(gender)
    if gender == 'M'
      gender = 'Male'
    elsif gender == 'F'
      gender = 'Female'
    end
    gender
  end

  def set_date(date) 
    Date.parse(date).strftime("%m/%d/%Y")
  end
end
x = CyrusReader.new("pipe.txt").get_file_contents
l = CyrusReader.new("comma.txt").get_file_contents
m = CyrusReader.new("space.txt").get_file_contents

l.merge!(m) {|key, val1, val2| val1 + val2}
puts l.merge!(x) {|key, val1, val2| val1 + val2}
binding.pry