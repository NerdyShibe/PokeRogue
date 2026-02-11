require "tty-prompt"
require "tty-box"
require "tty-cursor"

prompt = TTY::Prompt.new
cursor = TTY::Cursor

print cursor.clear_screen
box = TTY::Box.frame(
  width: 90,
  height: 20,
  title: { top_left: " TEST " }
)
print box
print cursor.move_to(2, 2)

choices = ["Option 1", "Option 2", "Option 3"]
prompt.select("Choose something:", choices)
