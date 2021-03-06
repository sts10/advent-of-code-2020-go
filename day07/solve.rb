def get_first_order_colors(color, a_big_hash)
  first_order_colors = []

  a_big_hash.each do |k, v|
    if v.include?(color)
      first_order_colors << k
    end
  end

  return first_order_colors.uniq
end

# def given_array_find_all_first_order_colors(colors_to_find, big_hash)
#   colors_to_find.map { |color_to_find| get_first_order_colors(color_to_find, big_hash) }.flatten
# end

rules = []
File.open("input").each_line do |line|
  rules << line
end

big_hash = Hash.new

rules.each do |rule|
  key = rule.split("contain")[0].split(" ")[0..1].join(" ")
  if rule.split("contain")[1].include?("no other")
    values = ["no other"]
  else
    values = rule.split("contain")[1].split(",").map { |a| a.split(" ")[1..2].join(" ") }
  end
  big_hash[key] = values
end

# Start with the first order colors of the color we're looking for
c = get_first_order_colors("shiny gold", big_hash)

# Now get the first order colors of _those_ colors
loop do
  c_len_before = c.uniq.length()
  c.each do |color|
    f = get_first_order_colors(color, big_hash)
    c = c + f
  end
  c_len_after = c.uniq.length()

  # If we didn't add any new colors, we know we're done. Can break out of loop.
  if c_len_before == c_len_after
    break
  end
end

# this use of uniq does A LOT of neccessary work for us
puts "answer to part 1 is " + c.uniq.length().to_s
