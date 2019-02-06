class Tile
    def initialize(tag)
        @tag = tag
        @flagged = false
        @revealed = false
    end

    def is_bomb?
        @tag == -1
    end

    def adj_bombs
        @tag if @tag >= 0
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