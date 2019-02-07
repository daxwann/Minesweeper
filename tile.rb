require_relative "./board"

class Tile

    def initialize(tag, coord, board)
        @bomb = tag == -1
        @adj_bombs = count_adj_bombs(tag, coord, board)
        @flagged = false
        @revealed = false
    end

    def is_adj_bomb?(x, y, board)
        size = board.count
        if x < 0 || x >= board.count || y < 0 || y >= board.count
            return false
        end
        board[x, y] == -1 ? true : false
    end

    def count_adj_bombs(tag, coord, board)
        return tag if tag == -1
        x, y = coord
        tag += 1 if is_adj_bomb?(x + 1, y, board)
        tag += 1 if is_adj_bomb?(x - 1, y, board)
        tag += 1 if is_adj_bomb?(x, y + 1, board)
        tag += 1 if is_adj_bomb?(x, y - 1, board)
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

    def flag
        @flag = !@flag
    end

    def is_revealed?
        @revealed
    end

    def reveal
        @revealed = true
    end
end