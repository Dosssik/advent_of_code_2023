result = File.open("input/1.txt").each_line.map do |line|
  digits = line.delete("^0-9")
  (digits[0] + digits[digits.length-1]).to_i
end

puts result.sum
