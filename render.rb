require "rubygems"
require "bundler/setup"

Bundler.require

palette = {
  dark0_hex: "#282828",
  dark0_i: 235,
  dark1_hex: "#3c3836",
  dark1_i: 237,
  dark2_hex: "#504945",
  dark2_i: 239,
  dark3_hex: "#665c54",
  dark3_i: 241,
  dark4_hex: "#7c6f64",
  dark4_i: 243,

  gray_hex: "#928374",
  gray_i: 245,

  light0_hex: "#fbf1c7",
  light0_i: 229,
  light1_hex: "#ebdbb2",
  light1_i: 223,
  light2_hex: "#d5c4a1",
  light2_i: 250,
  light3_hex: "#bdae93",
  light3_i: 248,
  light4_hex: "#a89984",
  light4_i: 246,

  bright_red_hex: "#fb4934",
  bright_red_i: 167,
  bright_green_hex: "#b8bb26",
  bright_green_i: 142,
  bright_yellow_hex: "#fabd2f",
  bright_yellow_i: 214,
  bright_blue_hex: "#83a598",
  bright_blue_i: 109,
  bright_purple_hex: "#d3869b",
  bright_purple_i: 175,
  bright_aqua_hex: "#8ec07c",
  bright_aqua_i: 108,
  bright_orange_hex: "#fe8019",
  bright_orange_i: 208,
}

template = File.read("templates/vim.mustache")

File.open("output/neonsmog.vim", "w") do |file|
  file.puts(Mustache.render(template, palette))
end
