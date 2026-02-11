# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "pokerogue"
  spec.version = "0.1.0"
  spec.authors = ["Fernando"]
  spec.email = ["fernando@example.com"]

  spec.summary = "A terminal-based Pokémon-like roguelike."
  spec.description = "A terminal-based Pokémon-like roguelike featuring procedural map generation and turn-based combat."
  spec.homepage = "https://github.com/fernando/pokerogue"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/fernando/pokerogue/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "tty-prompt", "~> 0.23"
  spec.add_dependency "tty-box", "~> 0.7"
  spec.add_dependency "tty-table", "~> 0.12"
  spec.add_dependency "pastel", "~> 0.8"
  spec.add_dependency "tty-cursor", "~> 0.7"
end
