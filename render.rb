require "rubygems"
require "bundler/setup"

Bundler.require

palette = {}
svg = File.open("palette/neonsmog.svg") { |f| Nokogiri::XML(f) }

%i[dark0 dark1 dark2 dark3 dark4 gray light0 light1 light2 light3
   light4 bright_red bright_green bright_yellow bright_blue bright_purple
   bright_aqua bright_orange].each do |key|
  palette["#{key}_hex".to_sym] = svg.at("##{key}_hex").attr("fill")
  palette["#{key}_i".to_sym] = svg.at("##{key}_i").text.strip
end

palette[:ansi0] = [] # dark0
palette[:ansi1] = [] # red
palette[:ansi2] = [] # green
palette[:ansi3] = [] # yellow
palette[:ansi4] = [] # blue
palette[:ansi5] = [] # purple
palette[:ansi6] = [] # aqua
palette[:ansi7] = [] # light4
palette[:ansi8] = [] # gray
palette[:ansi9] = [] # bright_red
palette[:ansi10] = [] # bright_green
palette[:ansi11] = [] # bright_yellow
palette[:ansi12] = [] # bright_blue
palette[:ansi13] = [] # bright_purple
palette[:ansi14] = [] # bright_aqua
palette[:ansi15] = [] # light0
palette[:ansi_background] = [] # dark0
palette[:ansi_badge] = [] # bright_orange, 50% opacity
palette[:ansi_bold] = [] # brighten light0
palette[:ansi_cursor] = [] # light0
palette[:ansi_cursor_guide] = [] # dark1
palette[:ansi_cursor_text] = [] # dark0
palette[:ansi_foreground] = [] # light0
palette[:ansi_link] = [] # bright_orange
palette[:ansi_selected_text] = [] # dark3
palette[:ansi_selection] = [] # light0

templates = {
  "neonsmog.vim" => File.read("templates/vim.mustache"),
}

templates.each do |filename, template|
  File.open("output/#{filename}", "w") do |file|
    file.puts(Mustache.render(template, palette))
  end
end
