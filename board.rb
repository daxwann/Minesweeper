require_relative "tile"

class Board
    def self.create_board
        
    end

    def initialize(size, bombs)
        @size = size
        @bombs = bombs
        @grid = Array.new(@size) {Array.new(@size)} 
    end

    def place_tiles
        
    end

    def randomize_bombs(size, bombs)
        arr_safe = Array.new(size ** 2 - bombs, 0)
        arr_bombs = Array.new(bombs, 1)
        arr_board = safe + bombs
        return arr_board.shuffle!
    end

    def []=(pos, val)
        x, y = pos
        if val == 'r'
            result = @grid[x][y].reveal
        elsif val == 'f'
            result = @grid[x][y].flag
        else
            result = 'error'
        end
        return result
    end
end