require "rubygems"
require "bundler/setup"

Bundler.require

DARKEN_AMT = 10

def hex_to_dec_rgb(hex)
  Chroma.paint(hex.to_s).to_rgb.scan(/\d+/).map { |d| d.to_i / 255.0 }
end

def darken(hex, amt = DARKEN_AMT)
  Chroma.paint(hex.to_s).darken(amt)
end

palette = {}
svg = File.open("palette/neonsmog.svg") { |f| Nokogiri::XML(f) }

keys = %i[dark0 dark1 dark2 dark3 dark4 gray light0 light1 light2 light3
   light4 bright_red bright_green bright_yellow bright_blue bright_purple
   bright_aqua bright_orange]

keys.each do |key|
  palette["#{key}_hex".to_sym] = svg.at("##{key}_hex").attr("fill")
  palette["#{key}_i".to_sym] = svg.at("##{key}_i").text.strip
end

ansis = {
  "0" => hex_to_dec_rgb(palette[:dark0_hex]),
  "1" => hex_to_dec_rgb(darken(palette[:bright_red_hex])),
  "2" => hex_to_dec_rgb(darken(palette[:bright_green_hex])),
  "3" => hex_to_dec_rgb(darken(palette[:bright_yellow_hex])),
  "4" => hex_to_dec_rgb(darken(palette[:bright_blue_hex])),
  "5" => hex_to_dec_rgb(darken(palette[:bright_purple_hex])),
  "6" => hex_to_dec_rgb(darken(palette[:bright_aqua_hex])),
  "7" => hex_to_dec_rgb(palette[:light4_hex]),
  "8" => hex_to_dec_rgb(palette[:gray_hex]),
  "9" => hex_to_dec_rgb(palette[:bright_red_hex]),
  "10" => hex_to_dec_rgb(palette[:bright_green_hex]),
  "11" => hex_to_dec_rgb(palette[:bright_yellow_hex]),
  "12" => hex_to_dec_rgb(palette[:bright_blue_hex]),
  "13" => hex_to_dec_rgb(palette[:bright_purple_hex]),
  "14" => hex_to_dec_rgb(palette[:bright_aqua_hex]),
  "15" => hex_to_dec_rgb(palette[:light0_hex]),
  "background" => hex_to_dec_rgb(palette[:dark0_hex]),
  "badge" => hex_to_dec_rgb(palette[:bright_orange_hex]),
  "bold" => hex_to_dec_rgb(palette[:light0_hex]),
  "cursor" => hex_to_dec_rgb(palette[:light1_hex]),
  "cursor_guide" => hex_to_dec_rgb(palette[:dark1_hex]),
  "cursor_text" => hex_to_dec_rgb(palette[:dark0_hex]),
  "foreground" => hex_to_dec_rgb(palette[:light1_hex]),
  "link" => hex_to_dec_rgb(palette[:bright_orange_hex]),
  "selected_text" => hex_to_dec_rgb(palette[:dark3_hex]),
  "selection" => hex_to_dec_rgb(palette[:light1_hex])
}


ansis.each do |key, rgb|
  ["r", "g", "b"].each_with_index do |c, i|
    palette["ansi_#{key}_#{c}".to_sym] = rgb[i]
  end
end

templates = {
  "neonsmog.vim" => File.read("templates/vim.mustache"),
  "neonsmog.itermcolors" => File.read("templates/itermcolors.mustache")
}

templates.each do |filename, template|
  File.open("output/#{filename}", "w") do |file|
    file.puts(Mustache.render(template, palette))
  end
end
