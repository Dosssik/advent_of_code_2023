# 467..114..
# ...*......
# ..35..633.
# ......#...
# 617*......
# .....+.58.
# ..592.....
# ......755.
# ...$.*....
# .664.598..

def is_digit(char)
  char.match?(/[0-9]/)
end

input = File.open("input/3.txt")

symbols_line_to_index = []
numbers_to_coordinates = []

input.each_with_index do |line, line_index|
  constructable_number = nil
  line.strip.chars.each_with_index { |char, char_index|
    if is_digit(char)
      if constructable_number == nil
        constructable_number = char
      else
        constructable_number += char
      end
    elsif char == "."
      if constructable_number != nil
        numbers_to_coordinates << [constructable_number.to_i, [line_index, char_index - constructable_number.to_s.length]]
        constructable_number = nil
      end
    else
      if constructable_number != nil
        numbers_to_coordinates << [constructable_number.to_i, [line_index, char_index - constructable_number.to_s.length]]
        constructable_number = nil
      end
      symbols_line_to_index << [line_index, char_index]
    end
  }
end

print numbers_to_coordinates
print symbols_line_to_index

class Range
  def overlaps?(other)
    cover?(other.first) || other.cover?(first)
  end
end

def is_collide(number_line, number_index, symbol_line, symbol_index, number_length)
  ((symbol_line - 1)..(symbol_line + 1)).include?(number_line) &&
    ((symbol_index - 1)..(symbol_index + 1)).overlaps?(number_index..number_index + number_length)
end

sum = 0

numbers_to_coordinates.each do |number_to_c|
  number = number_to_c.first

  number_line = number_to_c[1][0]
  number_index = number_to_c[1][1]

  symbols_line_to_index.each { |symbol_coordinates|
    symbol_line = symbol_coordinates[0]
    symbol_index = symbol_coordinates[1]
    if is_collide(number_line, number_index, symbol_line, symbol_index, number.to_s.length)
      puts "is_collide #{number}. sym-i=#{symbol_index}, l=#{number.to_s.length}, num-i=#{number_index} | s-l = #{symbol_line}, n-l = #{number_line}"
      sum += number
      break
    else
      # puts "is_collide false"
    end
  }
end

puts ""
puts sum