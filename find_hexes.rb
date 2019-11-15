input = File.read(ARGV[0])

hexes = Hash.new(0)

input.scan(/#[a-zA-Z0-9]{6}/).each do |hex|
  hexes[hex.downcase] += 1
end

hexes.to_a.sort_by { |a| a[1] }.reverse.each do |hex|
  puts "#{hex[0]}: #{hex[1]}"
end
