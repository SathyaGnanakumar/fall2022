class GameBoard
    # @max_row is an `Integer`
    # @max_column is an `Integer`
    attr_reader :max_row, :max_column

    def initialize(max_row, max_column)
        @max_row = max_row
        @max_column = max_column
        @successful_attacks = 0
        @game_board = Array.new(max_row){Array.new(max_column)}
    end

    # adds a Ship object to the GameBoard
    # returns Boolean
    # Returns true on successfully added the ship, false otherwise
    # Note that Position pair starts from 1 to max_row/max_column
    def add_ship(ship)
        #Boundary Checking
        #Ship: Start Pos, Orientation, Size

        ship_size = ship.size - 1 #Add to starting position for each direction

        #4 Cases: UP, DOWN, LEFT, and RIGHT

        #Use downto for left and down for loops to decrease col / row

        #"B, -" -> Indication that we have placed a ship on the board

        if ship.orientation.eql? "Up"
            if ship.start_position.row > @max_row || ship.start_position.column > @max_column || ship.start_position.row - ship_size < 1 || ship.start_position.column < 1
                return false
            end
            for x in (ship.start_position.row - 1).downto(ship.start_position.row - ship_size - 1)
                if @game_board[x][ship.start_position.column - 1] =~ /^B/   #Already have ship
                    return false #cannot add ship
                end
            end
                
            return add_ship_helper(ship) #Conditions checked - add ship up direction
        end

        if ship.orientation.eql? "Down"
            if ship.start_position.row  + ship_size > @max_row || ship.start_position.column > @max_column || ship.start_position.row < 1 || ship.start_position.column < 1
                return false
            end

            for x in ship.start_position.row - 1..ship.start_position.row - 1 + ship_size
                if @game_board[x][ship.start_position.column - 1] =~ /^B/   #Already have ship
                    return false #cannot add ship
                end
            end

            return add_ship_helper(ship)
            
        end

        if ship.orientation.eql? "Left"
            if ship.start_position.row > @max_row || ship.start_position.column > @max_column || ship.start_position.column - ship_size < 1 || ship.start_position.row < 1
                return False
            end

            for x in (ship.start_position.column - 1).downto(ship.start_position.column - ship_size - 1)
                if @game_board[ship.start_position.row - 1][x] =~ /^B/
                    return false
                end
            end

            return add_ship_helper(ship)
        end

        if ship.orientation.eql? "Right"
            if ship.start_position.row > @max_row || ship.start_position.column < 1 || ship.start_position.column + ship_size > @max_column || ship.start_position.row < 1
                return false
            end

            for x in (ship.start_position.column - 1).downto(ship.start_position.column - ship_size - 1)
                if @game_board[ship.start_position.row - 1][x] =~ /^B/
                    return false
                end
            end

            return add_ship_helper(ship)
        end

        return false #Invalid add ship operation
    end

    def add_ship_helper(ship)
        ship_size = ship.size - 1

        if ship.orientation.eql? "Up" #higher row to lower row
            for x in (ship.start_position.row - 1).downto(ship.start_position.row - ship_size - 1)
                @game_board[ship.start_position.column - 1][x] = "B, -"
            end

        end
        if ship.orientation.eql? "Down"
            for x in ship.start_position.row - 1..ship.start_position.row - 1 + ship_size
                @game_board[ship.start_position.column - 1][x] = "B, -"
            end
        end

        if ship.orientation.eql?  "Left"
            for x in (ship.start_position.column - 1).downto(ship.start_position.column - ship_size - 1)
                @game_board[ship.start_position.row - 1][x] = "B, -"
            end
        end

        if ship.orientation.eql? "Right"
            for x in ship.start_position.column - 1..ship.start_position.column - 1 + ship_size
                @game_board[ship.start_position.row - 1][x] = "B, -"
            end
        end

        return true
    end

    # return Boolean on whether attack was successful or not (hit a ship?)
    # return nil if Position is invalid (out of the boundary defined)
    def attack_pos(position)
        # check position

        # If not inside the grid -> Return nil

        if position.row < 1 || position.row > @max_row || position.column < 1 || position.column > @max_column
            return nil
        end

        #update your grid
        #Successful hit -> "B, A", Unsuccesful -> "-, A"

        if(@game_board[position.row - 1][position.column - 1].eql? "B")
            @successful_attacks += 1 #Increment counter variable 
            @game_board[position.row - 1][position.column - 1] = "B, A"
        else
            @game_board[position.row - 1][position.column - 1] = "-, A"
        end


        # return whether the attack was successful or not
        # We have a hit when the pattern is "B, A"
        if  @game_board[position.row - 1][position.column - 1] =~ /^B.*[^A]$/
            return true
        else
            return false
        end

    end

    # Number of successful attacks made by the "opponent" on this player GameBoard
    def num_successful_attacks
        return @successful_attacks  
    end

    # returns Boolean
    # returns True if all the ships are sunk.
    # Return false if at least one ship hasn't sunk.
    def all_sunk?
        for i in 0..@max_row - 1
            for j in 0..@max_column - 1
                if @game_board[i][j] =~ /^B.*[^A]$/ #B, A pattern means sunk so
                                                    #anything besides this means not sunk
                    return false  #Found a ship that is not sunk
                end
            end
        end

        return true #Every ship sunk so return true
    end


    # String representation of GameBoard (optional but recommended)
    def to_s
        for i in 0..@max_row - 1
            for j in 0..@max_column - 1
                puts "| " + @game_board[i][j] + " "  
            end

            puts "|"
        end
    end
end
