require_relative 'minesweeper'

class Player
  def initialize(size)
    @size = size
  end
  
  def get_coordinate
    loop do
      puts "Enter coordinates separated by comma. ex: 'x,y'"
      coord = gets.chomp
      exit if coord.downcase == 'q'
      return 's' if coord.downcase == 's'
      if valid_coord(coord)
        return coord.split(",").map do |c|
          c.to_i - 1
        end
      end
      puts "Coordinates not valid. Try again."
    end
  end

  def load_filename
    loop do
      puts "Enter name of YAML file. Enter 'return' to main menu"
      filename = gets.chomp
      return false if filename.downcase == 'return'
      return "#{filename}.yml" if File.exists?("#{filename}.yml")
      puts "File does not exist"
    end
  end

  def save_filename
    loop do
      puts "Enter name of YAML file. Enter 'return' to game"
      filename = gets.chomp
      return false if filename.downcase == 'return'
      if File.exists?("#{filename}.yml")
        if self.overwrite_file?
          return "#{filename}.yml"
        else
          next
        end
      end
      return "#{filename}.yml"
    end
  end

  def overwrite_file?
    loop do
      puts "File exists. Do you want to overwrite file? y/n"
      overwrite = gets.chomp
      return true if overwrite.downcase == 'y'
      return false if overwrite.downcase == 'n'
    end
  end

  def get_command
    loop do
      puts "Enter 'r' to reveal or 'f' to flag:"
      command = gets.chomp
      exit if command.downcase == 'q'
      return 's' if command.downcase == 's'
      return command if self.valid_command(command)
      puts "Command is not valid. Try again."
    end
  end

  def valid_coord(coord)
    return true if /^\s*[1-#{@size}]\s*\,\s*[1-#{@size}]\s*$/.match(coord)
    return false
  end

  def valid_command(command)
    command.downcase == 'r' || command.downcase == 'f'
  end
end