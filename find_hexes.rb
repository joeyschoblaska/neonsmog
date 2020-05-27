input = File.read(ARGV[0])

hexes = Hash.new(0)

input.scan(/#[a-zA-Z0-9]{6}/).each do |hex|
  hexes[hex.downcase] += 1
end

puts "<html><body><ul>"

hexes.to_a.sort_by { |a| a[1] }.reverse_each do |hex|
  puts "<li>#{hex[0]} (#{hex[1]}): <span style='color: #{hex[0]}; background-color: #{hex[0]}'>----------</span></li>"
end

puts "</ul></html></body>"
