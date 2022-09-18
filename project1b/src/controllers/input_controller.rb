require_relative '../models/game_board'
require_relative '../models/ship'
require_relative '../models/position'

# return a populated GameBoard or nil
# Return nil on any error (validation error or file opening error)
# If 5 valid ships added, return GameBoard; return nil otherwise
def read_ships_file(path)
    #Format: (2, 2), Right, 3

    board = GameBoard.new 10, 10
    num_ships_added = 0

    read_file_lines(path) {|s| 

        s = s.strip

        if num_ships_added == 5 # Once 5 ships added return the board
            break
        end

        if s =~ /^\((\d+),(\d+)\), (.+), (\d)$/

            row = $1.to_i
            col = $2.to_i
            orient = $3
            size = $4.to_i

            newPos = Position.new(row, col)
            newShip = Ship.new(newPos, orient, size)

            if board.add_ship(newShip) == true
                num_ships_added += 1    # Increment number of ships var
            end
        end
    }

    if num_ships_added != 5  #If we didnt add 5 ships then we have an error -> return nil
        return nil
    end

    return board

end


# return Array of Position or nil
# Returns nil on file open error
def read_attacks_file(path) #WORKS FINE -> NO PROBLEM

    posArray = Array.new()
    #idx = 0
    hello = read_file_lines(path) {|s|
        if s =~ /^\(([0-9]+),([0-9]+)\)$/
            row = $1.to_i
            col = $2.to_i
            newPos = Position.new(row, col) #Create new position from values
            posArray.push(newPos)
            #idx += 1
        end
    }
    #Check if array empty or file does not exist
    if posArray.length == 0 || hello == false
        return nil
    end
    
    return posArray
end


# ===========================================
# =====DON'T modify the following code=======
# ===========================================
# Use this code for reading files
# Pass a code block that would accept a file line
# and does something with it
# Returns True on successfully opening the file
# Returns False if file doesn't exist
def read_file_lines(path)
    return false unless File.exist? path
    if block_given?
        File.open(path).each do |line|
            yield line
        end
    end

    true
end
