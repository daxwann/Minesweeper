require_relative "board"
require_relative "player"
require "colorize"

class Minesweeper
  def initialize()
    @board = Board.new(9, 10)
    @player = Player.new(9)
    @file = nil
  end

  def new_game
    @board.create_new
  end

  def start
    until @board.revealed_all_safe?
      system("clear")
      @board.render
      coord = @player.get_coordinate
      command = @player.get_command
      if !self.safe_pick?(coord, command)
        self.game_over()
        return
      end
    end
    self.you_win()    
  end

  def safe_pick?(coord, command)
    if command == 'r'
      return false if @board[coord].is_bomb?
      if @board[coord].is_revealed?
        puts "Chosen square already revealed. Pick another square."
        sleep(2)
      end
      if @board[coord].is_flagged?
        puts "Chosen square is flagged. Unflag it or pick another square"
        sleep(2)
      else
        @board.reveal_tile(coord)
      end
    elsif command == 'f'
      @board.toggle_flag(coord)
    end
    return true
  end

  def game_over()
    system("clear")
    puts "Game over!".colorize(:red)
    puts
    @board.reveal_all_bombs
    @board.render
  end

  def you_win()
    system("clear")
    puts "You WIN!".colorize(:green)
    puts
    @board.render
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Minesweeper.new
  game.new_game
  game.start
end