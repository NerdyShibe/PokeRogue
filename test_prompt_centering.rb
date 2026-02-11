require "tty-prompt"
require "tty-box"
require "tty-cursor"
require "tty-screen"

prompt = TTY::Prompt.new
cursor = TTY::Cursor

width = 60
height = 20

print cursor.clear_screen
box = TTY::Box.frame(
  width: width,
  height: height,
  align: :center,
  title: { top_left: " TEST " }
) do
  "Some centered content
And more"
end

print box

# Calculate center for prompt
# "Choose something?" is ~17 chars.
# "Option 1" is ~8 chars.
# Max width approx 20.
# Center of box is width/2 = 30.
# Start column = 30 - (20/2) = 20.

print cursor.move_to(20, 10) # col, row

choices = ["   Option 1", "   Option 2", "   Option 3"]

# Attempting to use indent if available, or just relying on cursor (which might fail on redraws)
# TTY::Prompt doesn't have a direct 'indent' for the whole block usually.
# Let's try just moving cursor.
begin
  prompt.select("Choose something?", choices)
rescue => e
  puts e.message
end
