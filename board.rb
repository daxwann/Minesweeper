require_relative "./tile"

class Board
    def initialize(size, bombs)
        @size = size
        @bombs = bombs
        @grid = create_board(size, bombs)
    end

    def create_board(size, bombs)
       grid = place_bombs(size, bombs)
       grid = place_tiles(grid)
       return grid
    end

    def place_bombs(size, bombs)
        grid = Array.new
        safe_sqs = Array.new(size ** 2 - bombs, 0)
        bomb_sqs = Array.new(bombs, -1)
        all_sqs = safe_sqs + bomb_sqs
        all_sqs.shuffle!
        (0...size).each do |row|
            grid << all_sqs[(row * 9)..((row * 9) + 8)]
        end
        return grid
    end

    def place_tiles(grid)
        grid.map.with_index do |row, y|
            row.map.with_index do |tag, x|
                return Tile.new(tag, [x, y], grid)
            end
        end
        p grid
        return grid
    end

    def []=(pos, val)
        x, y = pos
        if val == 'r'
            result = @grid[y][x].reveal
        elsif val == 'f'
            result = @grid[y][x].flag
        else
            result = 'error'
        end
        return result
    end

    def [](pos)
        x, y = pos
        return @grid[y][x]
    end
end