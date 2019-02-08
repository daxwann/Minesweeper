require_relative "./board"

class Tile

    def initialize(tag, coord, board)
        @bomb = tag == 'b'
        @adj_bombs = count_adj_bombs(tag, coord, board)
        @flagged = false
        @revealed = false
    end

    def is_adj_bomb?(coord, board)
        x, y = coord
        size = board.count
        if x < 0 || x >= size || y < 0 || y >= size
            return false
        end
        return board[y][x] == 'b' ? true : false
    end

    def count_adj_bombs(tag, coord, board)
        return tag if tag == 'b'
        Board.find_adj_coord(coord, board.count).each do |adj_coord|
            tag += 1 if is_adj_bomb?(adj_coord, board)
        end
        return tag
    end

    def inspect
        {
            'bomb'=>@bomb, 
            'adjacent bombs'=>@adj_bombs, 
            'flagged'=>@flagged,
            'revealed'=>@revealed
        }.inspect
    end

    def is_bomb?
        @bomb
    end

    def adj_bombs_count
        @adj_bombs
    end

    def is_flagged?
        @flagged
    end

    def toggle_flag
        @flagged = !@flagged
    end

    def is_revealed?
        @revealed
    end

    def reveal
        @revealed = true
    end
end