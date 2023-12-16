input = File.open("input/5.txt")

seeds = []
transformations = []

transformation_parsing_index = -1

input.each_line do |line|
  if line.start_with? "seeds"
    seeds = line.split(": ").last.strip.split(" ").map { |seed| seed.to_i }
  elsif line.include? ":"

  elsif line == "\n"
    transformation_parsing_index += 1
  else
    mappings = line.strip.split(" ").map { |mapping| mapping.to_i }
    if transformations[transformation_parsing_index] == nil
      transformations[transformation_parsing_index] = []
    end
    transformations[transformation_parsing_index] << mappings
  end
end

puts "validate parsing:"
puts "seeds: #{seeds}"
transformations.each_with_index do |item, index|
  puts "transform_#{index}: #{item}"
end
puts ""

transformed_seeds = []
handled_original_seeds = Set.new([])

def transform_for_seed(seed, transformations, transformed_seeds, handled_original_seeds)
  # puts "transformations for seed #{seed}"
  transformed_value = seed
  transformations.each { |transformation|
    transformation.each { |mapping|
      source = mapping[1]
      dest = mapping[0]
      length = mapping[2]
      if transformed_value >= source && transformed_value < (source + length)
        new_value = transformed_value - source + dest
        # puts "transformation for seed=#{seed}, matched with mapping=#{mapping}"
        # puts "updating transformed_value from #{transformed_value} to #{new_value}"
        transformed_value = new_value
        break
      end
    }
    # puts "end of transformation #{transformation}"
  }
  transformed_seeds << transformed_value
  handled_original_seeds << seed
  # puts
end

seeds.each do |seed|
  transform_for_seed(seed, transformations, transformed_seeds, handled_original_seeds)
end

puts "transformed seeds: #{transformed_seeds}"
puts "result(part_1): #{transformed_seeds.min}"

############################## Part 2

$seed_ranges = seeds.each_slice(2).to_a.map { |pair_array|
  pair_array.first..(pair_array.first + pair_array.last - 1)
}

def reversed_transform(seed, transformations)
  transformed_value = seed
  transformations.each { |transformation|
    transformation.each { |mapping|
      source = mapping[0]
      dest = mapping[1]
      length = mapping[2]
      if transformed_value >= source && transformed_value < (source + length)
        new_value = transformed_value - source + dest
        # puts "transformation for seed=#{seed}, matched with mapping=#{mapping}"
        # puts "updating transformed_value from #{transformed_value} to #{new_value}"
        transformed_value = new_value
        break
      end
    }
  }
  transformed_value
end

def value_exists_in_seed_ranges(value)
  found = false
  $seed_ranges.each do |range|
    if range.include?(value)
      found = true
      break
    end
  end
  found
end

transformations.last.sort_by(&:first).each do |mapping|
  dest = mapping[0]
  length = mapping[2]
  (dest..(dest + length -1)).each do |guessed_result|
    guessed_seed = reversed_transform(guessed_result, transformations.reverse)
    if value_exists_in_seed_ranges(guessed_seed)
      puts "FOUND PART 2 result, ARRRRRIVAAA - #{guessed_result}"
      break
    end
  end
end


