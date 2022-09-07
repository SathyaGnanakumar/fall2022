class PhoneBook
    def initialize
        @listPhoneBook = Hash.new #No default value -> Caused error
        @notListPhoneBook = Hash.new 
    end

    def add(name, number, is_listed)

        #Pre-Add Conditions to Check
        if(@listPhoneBook.has_key?(name)  || @notListPhoneBook.has_key?(name)|| !(number =~ /^[0-9]{3}-[0-9]{3}-[0-9]{4}$/)|| (is_listed && @listPhoneBook.has_value?(number)))
            return false
        end

        if is_listed
            @listPhoneBook[name] = number
            return true
        end

        if is_listed == false
            @notListPhoneBook[name] = number
            return true     
        end

        return false #Unsuccessful add
    end

    def lookup(name)
        #Looking only through the listed ones since if is_listed is false
        # the value nil is returned 
        return @listPhoneBook[name]
    end

    def lookupByNum(number)
        #Look only through listed ones and return the key associated 
        #with the value to find
        index = @listPhoneBook.values.find_index(number);

        if index == nil
            return nil
        end

        if @listPhoneBook.has_value?(number)
            return @listPhoneBook.keys[index]
        end


    end

    def namesByAc(areacode)
        namesFound = [] # result array for names that match areacode
        listPhoneIndex = 0
        notListPhoneIndex = 0
        namesIndex = 0 

        while listPhoneIndex < @listPhoneBook.keys.length #listed phonebook
            if @listPhoneBook.values[listPhoneIndex] =~ /^#{areacode}/
                namesFound[namesIndex] = @listPhoneBook.keys[listPhoneIndex]
                namesIndex += 1 # Only increment when names is added
            end

            listPhoneIndex += 1
        end

        while notListPhoneIndex < @notListPhoneBook.keys.length #unlisted phonebook
            if @notListPhoneBook.values[notListPhoneIndex] =~ /^#{areacode}/
                namesFound[namesIndex] = @notListPhoneBook.keys[notListPhoneIndex]
                namesIndex += 1 # Only increment when names is added
            end

            notListPhoneIndex += 1
        end


        return namesFound
    end
end
