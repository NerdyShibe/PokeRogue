# frozen_string_literal: true

require "tty-prompt"
require "pastel"
require "tty-box"
require "tty-cursor"

module Pokerogue
  class CLI
    def initialize
      @prompt = TTY::Prompt.new
      @pastel = Pastel.new
      @cursor = TTY::Cursor
    end

    def start
      clear_screen
      show_welcome_screen
      main_menu
    end

    private

    def clear_screen
      print "\e[2J\e[f"
    end

    def with_frame(title: "PokéRogue", height: 15, content: nil)
      @cursor.clear_screen
      
      # Clean up content if provided to ensure perfect centering
      display_content = if content
        content.strip.split("\n").map(&:strip).join("\n")
      else
        ""
      end

      box = TTY::Box.frame(
        width: 90,
        height: height,
        align: :center,
        padding: 1,
        title: { top_left: " #{title} ", bottom_right: " v0.1 " }
      ) do
        display_content
      end
      
      print box
      
      if block_given?
        # Move cursor to a safe spot inside the box for interactive elements
        # If there's content, we move below it; otherwise, we go to the middle
        start_line = content ? (height / 2) : (height / 2) - 1
        print @cursor.move_to(start_line, 5)
        yield
      end
    end

    def show_welcome_screen
      content = <<~TEXT
        Welcome to the world of
        #{@pastel.bold.bright_red("PokeRogue")}
        A terminal roguelike adventure!
        
        #{@pastel.dim("Press any key to continue...")}
      TEXT

      with_frame(content: content, height: 15) do
        @prompt.keypress("")
      end
    end

    def main_menu
      action = nil
      # We pass nil content so the block (the prompt) can be positioned manually
      with_frame(height: 12) do
        choices = [
          { name: "New Run", value: :new_run },
          { name: "Settings", value: :settings },
          { name: "Exit", value: :exit }
        ]

        action = @prompt.select("What would you like to do?", choices)
      end

      case action
      when :new_run
        start_new_run
      when :settings
        show_settings
      when :exit
        puts "Goodbye!"
        exit
      end
    end

    def show_settings
      with_frame(height: 10) do
        puts "Settings not implemented yet."
        @prompt.keypress("Press enter to return...")
      end
      main_menu
    end

    def start_new_run
      with_frame(height: 10) do
        puts @pastel.cyan("Starting a new adventure...")
        @prompt.keypress("Press any key to choose your starter...")
      end
      choose_starter
    end

    def choose_starter
      starters = [
        { name: "Bulbasaur (Grass)", value: :bulbasaur },
        { name: "Charmander (Fire)", value: :charmander },
        { name: "Squirtle (Water)", value: :squirtle }
      ]
      
      choice = nil
      with_frame(height: 15) do
        choice = @prompt.select("Choose your starter Pokemon:", starters)
      end
      
      with_frame(height: 10) do
        puts "You chose #{@pastel.green(choice.to_s.capitalize)}!"
        puts "Let the journey begin..."
        @prompt.keypress("Press any key to enter the first floor...")
      end
      
      # Next step: Map Generation
    end
  end
end
