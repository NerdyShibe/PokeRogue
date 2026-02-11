require "tty-box"
require "tty-cursor"
require "tty-reader"
require "pastel"
require "debug"

class CustomMenu
  def initialize
    @cursor = TTY::Cursor
    @reader = TTY::Reader.new
    @pastel = Pastel.new
  end

  def run
    debugger
    print @cursor.clear_screen
    
    # Draw the static frame
    print TTY::Box.frame(
      top: 0,
      left: 0,
      width: 60,
      height: 20,
      title: { top_left: " CUSTOM MENU " }
    )

    choices = [
      { name: "Start New Game", value: :new },
      { name: "Load Game", value: :load },
      { name: "Options", value: :options },
      { name: "Quit", value: :quit }
    ]

    selected = custom_select("What will you do?", choices, width: 60, top_offset: 5)
    
    print @cursor.move_to(0, 21)
    puts "Selected: #{selected}"
  end

  def custom_select(question, choices, width:, top_offset:)
    selected_index = 0
    loop do
      # 1. Render Menu
      render_menu(question, choices, selected_index, width, top_offset)

      # 2. Handle Input
      input = @reader.read_keypress
      case input
      when "\e[A", "k", "w" # Up
        selected_index = (selected_index - 1) % choices.length
      when "\e[B", "j", "s" # Down
        selected_index = (selected_index + 1) % choices.length
      when "
", "
", " " # Enter / Space
        return choices[selected_index][:value]
      when "\u0003", "\e" # Ctrl+C or Esc
        exit
      end
    end
  end

  def render_menu(question, choices, selected_index, width, top_offset)
    # Calculate dimensions
    longest_label = choices.map { |c| c[:name].length }.max
    menu_width = longest_label + 4 # +2 for "> ", +2 for extra spacing
    left_pad = (width - menu_width) / 2
    
    # Move to start position
    current_row = top_offset
    
    # Print Question
    question_pad = (width - question.length) / 2
    print @cursor.move_to(question_pad, current_row)
    print @pastel.bold(question)
    current_row += 2

    # Print Options
    choices.each_with_index do |choice, index|
      print @cursor.move_to(left_pad, current_row)
      
      if index == selected_index
        print @pastel.green("> #{choice[:name]}")
      else
        print "  #{choice[:name]}"
      end
      current_row += 1
    end
  end
end

CustomMenu.new.run
