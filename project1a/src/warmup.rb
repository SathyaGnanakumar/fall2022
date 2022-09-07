def fib(n)

    # Store in array
    fibArray = []

    if n == 0
        return fibArray # n is 0 so nothing to add to array
    end

    for i in 0..n - 1
        fibArray[i] = fibGenerator(i) # Generate fib for each array entry
    end

    return fibArray

end

def fibGenerator(n)
    if n == 0
        return 0
    elsif n == 1
        return 1
    end

    return fibGenerator(n - 1) + fibGenerator(n - 2) 
    
end

def isPalindrome(n)
    #Convert to string and then use two pointer method 
    #One pointer from left and one from end and end when they meet

    str = n.to_s
    left = 0
    right = str.length - 1

    while left <= right
        if str[left] != str[right] #I f mismatch return false immediately
            return false
        end

        left = left + 1 # Move pointers after each successful comparision
        right = right - 1

    end

    return true
end

def nthmax(n, a)
    #[1, 2, 3, 4] -> 2nd largest is 3, Length = 4 - 2 = 2 -> a[2] = 3
    sortArray = a.sort
    valToReturn = sortArray.length - n - 1

    if n < 0 || n > a.length - 1
        return nil
    end

    return sortArray[valToReturn]

end

def freq(s)
    #Find the character with highest frequency -> Dictionary

    if s == "" #Base Case
        return ""
    end

    hash = Hash.new(0) #Create dict with default value 0
    index = 0
    max = 0

    while index < s.length
        hash[s[index]] += 1
        if(hash[s[index]] > max)
            max = hash[s[index]]
            mostFreqChar = s[index]
        end
        index += 1
    end

    return mostFreqChar

end

def zipHash(arr1, arr2)
    #First the arrays must be same length or else return nil
    if arr1.length != arr2.length
        return nil
    end

    #Perform check one-by-one
    index = 0
    hashToRet = Hash.new

    while index < arr1.length
        hashToRet[arr1[index]] = arr2[index] #Assign key value pair
        index += 1
    end

    return hashToRet
end

def hashToArray(hash)
    #Converting hash to array -> Need keys and values
    keys = hash.keys
    values = hash.values
    arr = Array.new(keys.length){Array.new(2)}

    idx = 0
    while idx < keys.length
        arr[idx][0] = keys[idx]   #First element in the pair is the key
        arr[idx][1] = values[idx] #Second element in pair is the value
        idx += 1
    end   

    return arr
end
