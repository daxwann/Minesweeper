require_relative 'minesweeper'

class Player
  def initialize(size)
    @size = size
  end
  
  def get_coordinate
    loop do
      puts "Enter coordinates separated by comma. ex: 'x,y'"
      coord = gets.chomp
      Minesweeper.quit if command.downcase == 'q'
      if command.downcase == 's'
        Minesweeper.save
        next
      end
      if valid_coord(coord)
        return coord.split(",").map do |c|
          c.to_i - 1
        end
      end
      puts "Coordinates not valid. Try again."
    end
  end

  def get_command
    loop do
      puts "Enter 'r' to reveal or 'f' to flag:"
      command = gets.chomp
      Minesweeper.quit if command.downcase == 'q'
      if command.downcase == 's'
        Minesweeper.save
        next
      end
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