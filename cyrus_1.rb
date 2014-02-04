require 'date'
require 'pry'

class CyrusReader
  attr_reader :filename

  def initialize(filename)
    @raw_data = File.open(filename).read
    @data = {:LastName => [], :FirstName => [], :Gender => [], :FavoriteColor => [], :DateOfBirth => []}
  end

  def check_file
    return 'pipe' if @raw_data.include?(" | ")
    return 'comma' if @raw_data.include?(", ")
    return 'space' if @raw_data.include?(" ")

  end

  def parse_pipe_file
    @raw_data.lines.collect do |line|
      line = line.split(" | ").collect { |x| x.strip }
      @data[:LastName] << line[0]
      @data[:FirstName] << line[1]
      @data[:Gender] << set_gender(line[3])
      @data[:DateOfBirth] << set_date(line[5])
      @data[:FavoriteColor] << line[4]
    end
    binding.pry
  end

  def parse_comma_file
    File.open(@filename) do |file|
      file.each do |line|
        info = line.split(", ")
        data[:LastName] << info[0]
        data[:FirstName] << info[1]
        data[:Gender] << info[2]                  
        data[:FavoriteColor] << info[3]
        data[:DateOfBirth] << info[4].tr("\n", '')
      end
    end
  end

  def parse_space_file
    data[:LastName] << info[0]
    data[:FirstName] << info[1]
    data[:Gender] << set_gender(info[3])
    data[:DateOfBirth] << set_date(info[4].tr("\n", ''))
    data[:FavoriteColor] << info[5]
  end

  def set_gender(gender)
    if gender == 'M'
      gender = 'Male'
    elsif gender == 'F'
      gender = 'Female'
    end
    gender
  end

  def set_date(date_args)
    date_args = date_args.split(/(?:\/|-)/).collect { |x| x.to_i}
    Date.new(date_args[2], date_args[0], date_args[1])
  end
end
x = CyrusReader.new("pipe.txt")
puts x.parse_pipe_file