s = “The quick, brown fox jumps over, the lazy dog.”
s =~ /([a-z]+) ([a-z]+) ([a-z]+),/
puts $2 