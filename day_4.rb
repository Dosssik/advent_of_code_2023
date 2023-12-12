$cards = File.open("input/4.txt")
$lines = IO.readlines("input/4.txt")


part_one_score = 0
$part_two_score = 0

def get_matching_numbers_amount(actual_numbers, winning_numbers)
  matching_numbers_amount = 0
  actual_numbers.each { |number|
    if winning_numbers.include? number
      matching_numbers_amount += 1
    end
  }
  matching_numbers_amount
end

def get_card_winning_numbers(card)
  card.split(":").last.split("|").first.strip.split(" ")
end

def get_card_actual_numbers(card)
  card.split(":").last.split("|").last.strip.split(" ")
end
def check_for_part_two_points(line_index)
  winning_numbers = get_card_winning_numbers($lines[line_index])
  actual_numbers = get_card_actual_numbers($lines[line_index])

  matching_numbers_amount = get_matching_numbers_amount(actual_numbers, winning_numbers)
  $part_two_score += 1
  if matching_numbers_amount > 0
    ((line_index+1)..(line_index+matching_numbers_amount)).each do |index|
      check_for_part_two_points(index)
    end
  end
end


$cards.each_line.each_with_index do |card, index |
  winning_numbers = get_card_winning_numbers(card)
  actual_numbers = get_card_actual_numbers(card)

  matching_numbers_amount = get_matching_numbers_amount(actual_numbers, winning_numbers)

  if matching_numbers_amount > 0
    part_one_score += 2 ** (matching_numbers_amount - 1)
  end
  check_for_part_two_points(index)
end
puts "Part 1, answer=#{part_one_score}"
puts "Part 2, answer=#{$part_two_score}"

