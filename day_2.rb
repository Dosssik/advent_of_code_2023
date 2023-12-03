def get_cubes_amount(color, cube)
  cube.strip.gsub(" #{color}", "").to_i
end

def should_update_max_for_color(cube, color, current_max)
  (cube.include? color) && get_cubes_amount(color, cube) > current_max
end

max_red = 12
max_green = 13
max_blue = 14

ids_sum = 0
min_set_sum = 0

File.open("input/2.txt").each_line.map do |line|
  game_id = line.split(":").first.gsub("Game ", "").to_i

  highest_red = 0
  highest_green = 0
  highest_blue = 0
  line.split(":").last.strip.split(";").each { |grab|
    grab.split(",").each { |cube|
      if should_update_max_for_color(cube, "red", highest_red)
        highest_red = get_cubes_amount("red", cube)
      elsif should_update_max_for_color(cube, "blue", highest_blue)
        highest_blue = get_cubes_amount("blue", cube)
      elsif should_update_max_for_color(cube, "green", highest_green)
        highest_green = get_cubes_amount("green", cube)
      end
    }
  }
  min_set_sum = min_set_sum + highest_red * highest_green * highest_blue
  if highest_blue <= max_blue && highest_green <= max_green && highest_red <= max_red
    ids_sum = ids_sum + game_id
  end
end

puts "IDs sum = #{ids_sum}"
puts "Min sets sum = #{min_set_sum}"