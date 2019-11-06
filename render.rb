require "rubygems"
require "bundler/setup"

Bundler.require

palette = {}
svg = File.open("palette/neonsmog.svg") { |f| Nokogiri::XML(f) }

keys = %i[dark0 dark1 dark2 dark3 dark4 gray light0 light1 light2 light3
          light4 bright_red bright_green bright_yellow bright_blue bright_purple
          bright_aqua bright_orange]

templates = {
  "neonsmog.vim" => File.read("templates/vim.mustache")
}

keys.each do |key|
  palette["#{key}_hex".to_sym] = svg.at("##{key}_hex").attr("fill")
  palette["#{key}_i".to_sym] = svg.at("##{key}_i").text.strip
end

templates.each do |filename, template|
  File.open("output/#{filename}", "w") do |file|
    file.puts(Mustache.render(template, palette))
  end
end
