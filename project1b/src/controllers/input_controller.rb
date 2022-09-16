require_relative '../models/game_board'
require_relative '../models/ship'
require_relative '../models/position'

# return a populated GameBoard or nil
# Return nil on any error (validation error or file opening error)
# If 5 valid ships added, return GameBoard; return nil otherwise
def read_ships_file(path)

    #Format: (2,2), Right, 2

    board = GameBoard.new 10, 10
    num_ships_added = 0

    read_file_lines(path) {|s|
        if num_ships_added < 5 #We stop adding ships once we have added 5

            modified = s.split #F(2,2), This is what the output after split is 
                           #Right,  We need to remove ending commas on second entry
                           #3

            modified[1] = modified[1].delete(", ") #All the commas are gone now
            modified[2] = modified[2].delete(", ")
            #Now check the values

            if modified[0] =~ /([0-9]+),([0-9]+)/ && modified[1] =~ /(Up|Down|Left|Right)/ && modified[2] =~ /[1-5]/
                rowNum = $1.to_i #Extract row and col from modified[0]
                colNum = $2.to_i

                posToAdd = Position.new(rowNum, colNum)
                shipToAdd = Ship.new(posToAdd, modified[1], modified[2].to_i)

                if board.add_ship(shipToAdd) == true # Check if its possible
                    num_ships_added += 1 #We added a ship so increment counter
                end
            end
        end
        
    }

    if num_ships_added != 5 #5 valid ships not added so we return nil
        return nil
    end

    return board
end


# return Array of Position or nil
# Returns nil on file open error
def read_attacks_file(path)
    posArray = Array.new
    idx = 0
    read_file_lines(path) {|s|
        if s =~ /^\((\d+),(\d+)\)$/
            row = $1.to_i
            col = $2.to_i
            newPos = Position.new(row, col) #Create new position from values
            posArray[idx] = newPos; #Add to array
            idx += 1
        end
    }
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
