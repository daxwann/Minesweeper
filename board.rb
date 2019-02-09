require_relative "./tile"
require "colorize"
require "yaml"

class Board
    def self.find_adj_coord(coord, size)
        x, y = coord
        max = size - 1
        adj_coord = Array.new
        adj_coord << [x + 1, y] if x < max
        adj_coord << [x - 1, y] if x > 0
        adj_coord << [x, y + 1] if y < max
        adj_coord << [x, y - 1] if y > 0
        adj_coord << [x - 1, y - 1] if x > 0 && y > 0
        adj_coord << [x + 1, y + 1] if x < max && y < max
        adj_coord << [x - 1, y + 1] if x > 0 && y < max
        adj_coord << [x + 1, y - 1] if x < max && y > 0
        return adj_coord
    end

    def initialize(size, bombs)
        @size = size
        @bombs = bombs
        @tiles
    end

    def create_new
        @tiles = create_board(@size, @bombs)
    end

    def save_board(file)
        File.open(file, "w") do |file|
            file.write(@tiles.to_yaml)
        end
        puts "Game saved to #{file}"
        puts
    end

    def load_board(file)
        @tiles = YAML.load_file(file)
        if !@tiles
            puts "File not loaded"
            sleep(2)
        else
            puts "File loaded successfully"
            sleep(2)
        end
    end

    def create_board(size, bombs)
       grid = place_bombs(size, bombs)
       tiles = create_tiles(grid)
       return tiles
    end

    def place_bombs(size, bombs)
        grid = Array.new
        safe_sqs = Array.new(size ** 2 - bombs, 0)
        bomb_sqs = Array.new(bombs, 'b')
        all_sqs = safe_sqs + bomb_sqs
        all_sqs.shuffle!
        (0...size).each do |row|
            grid << all_sqs[(row * size)..((row * size) + size - 1)]
        end
        return grid
    end

    def create_tiles(grid)
        tiles = Array.new
        grid.each.with_index do |row, y|
            tiles << row.map.with_index do |tag, x|
                Tile.new(tag, [x, y], grid)
            end
        end
        return tiles
    end

    def options
        puts "Enter 's' to save".cyan
        puts "Enter 'q' to quit".cyan
    end

    def render
        self.options
        puts
        puts "   1 2 3 4 5 6 7 8 9"
        puts "   - - - - - - - - -".colorize(:light_magenta)
        @tiles.each.with_index do |row, i|
            print (i + 1).to_s + " |".colorize(:light_magenta)
            row.each.with_index do |tile, k|
                print " " if k > 0
                if tile.is_flagged?
                    print 'F'.colorize(:yellow)
                elsif !tile.is_revealed?
                    print '*'
                elsif tile.adj_bombs_count == 0
                    print '_'.colorize(:light_green)
                elsif tile.is_bomb?
                    print 'b'.colorize(:red)
                else
                    print tile.adj_bombs_count.to_s.colorize(:cyan)
                end
            end
            print "|".colorize(:light_magenta)
            puts
        end
        puts "   - - - - - - - - -".colorize(:light_magenta)
    end

    def reveal_tile(coord)
        return false if self[coord].is_bomb?
        return false if self[coord].is_revealed?
        self[coord].reveal
        if self[coord].adj_bombs_count == 0
            self.class.find_adj_coord(coord, @size).each do |adj|
                self.reveal_tile(adj) if adj
            end
        end
    end

    def reveal_all_bombs
        @tiles.each do |row|
            row.each do |tile|
                tile.reveal if tile.is_bomb?
            end
        end
    end

    def revealed_all_safe?
        @tiles.each do |row|
            row.each do |tile|
                return false if !tile.is_bomb? && !tile.is_revealed?
            end
        end
        return true
    end

    def toggle_flag(coord)
        self[coord].toggle_flag
    end

    def [](coord)
        x, y = coord
        return @tiles[y][x]
    end
end