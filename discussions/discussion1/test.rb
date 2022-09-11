def fun(p)
    p2 = Proc.new { p.call }
    puts "Inside fun"
    return p2
  end

  
  fun(pr)