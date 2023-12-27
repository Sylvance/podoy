# frozen_string_literal: true

require "thor"

module Podoy
  # Cli
  class Cli < Thor
    desc "test", "Test command"
    def test
      # add commands here
      puts :hello
    end

    desc "version", "Display the Podoy version"
    def version
      puts Podoy::VERSION
    end
  end
end
