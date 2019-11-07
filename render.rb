require "rubygems"
require "bundler/setup"

Bundler.require

DARKEN_AMT = 10
LIGHTEN_AMT = 10

def hex_to_dec_rgb(hex)
  Chroma.paint(hex.to_s).to_rgb.scan(/\d+/).map { |d| d.to_i / 255.0 }
end

def darken(hex, amt = DARKEN_AMT)
  Chroma.paint(hex.to_s).darken(amt)
end

def lighten(hex, amt = LIGHTEN_AMT)
  Chroma.paint(hex.to_s).lighten(amt)
end

palette = {}
svg = File.open("palette/neonsmog.svg") { |f| Nokogiri::XML(f) }

%i[dark0 dark1 dark2 dark3 dark4 gray light0 light1 light2 light3
   light4 bright_red bright_green bright_yellow bright_blue bright_purple
   bright_aqua bright_orange].each do |key|
  palette["#{key}_hex".to_sym] = svg.at("##{key}_hex").attr("fill")
  palette["#{key}_i".to_sym] = svg.at("##{key}_i").text.strip
end

palette[:ansi0] = hex_to_dec_rgb(palette[:dark0_hex])
palette[:ansi1] = hex_to_dec_rgb(darken(palette[:bright_red_hex]))
palette[:ansi2] = hex_to_dec_rgb(darken(palette[:bright_green_hex]))
palette[:ansi3] = hex_to_dec_rgb(darken(palette[:bright_yellow_hex]))
palette[:ansi4] = hex_to_dec_rgb(darken(palette[:bright_blue_hex]))
palette[:ansi5] = hex_to_dec_rgb(darken(palette[:bright_purple_hex]))
palette[:ansi6] = hex_to_dec_rgb(darken(palette[:bright_aqua_hex]))
palette[:ansi7] = hex_to_dec_rgb(palette[:light4_hex])
palette[:ansi8] = hex_to_dec_rgb(palette[:gray_hex])
palette[:ansi9] = hex_to_dec_rgb(palette[:bright_red_hex])
palette[:ansi10] = hex_to_dec_rgb(palette[:bright_green_hex])
palette[:ansi11] = hex_to_dec_rgb(palette[:bright_yellow_hex])
palette[:ansi12] = hex_to_dec_rgb(palette[:bright_blue_hex])
palette[:ansi13] = hex_to_dec_rgb(palette[:bright_purple_hex])
palette[:ansi14] = hex_to_dec_rgb(palette[:bright_aqua_hex])
palette[:ansi15] = hex_to_dec_rgb(palette[:light0_hex])
palette[:ansi_background] = hex_to_dec_rgb(palette[:dark0_hex])
palette[:ansi_badge] = hex_to_dec_rgb(palette[:bright_orange_hex])
palette[:ansi_bold] = hex_to_dec_rgb(lighten(palette[:light0_hex]))
palette[:ansi_cursor] = hex_to_dec_rgb(palette[:light0_hex])
palette[:ansi_cursor_guide] = hex_to_dec_rgb(palette[:dark1_hex])
palette[:ansi_cursor_text] = hex_to_dec_rgb(palette[:dark0_hex])
palette[:ansi_foreground] = hex_to_dec_rgb(palette[:light0_hex])
palette[:ansi_link] = hex_to_dec_rgb(palette[:bright_orange_hex])
palette[:ansi_selected_text] = hex_to_dec_rgb(palette[:dark3_hex])
palette[:ansi_selection] = hex_to_dec_rgb(palette[:light0_hex])

templates = {
  "neonsmog.vim" => File.read("templates/vim.mustache"),
}

templates.each do |filename, template|
  File.open("output/#{filename}", "w") do |file|
    file.puts(Mustache.render(template, palette))
  end
end
