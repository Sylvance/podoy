# frozen_string_literal: true

Dir[File.join(__dir__, "podoy", "*.rb")].sort.each { |file| require file }

module Podoy
  class Error < StandardError; end
  # Your code goes here...
end
