# frozen_string_literal: true

Dir[File.join(__dir__, "podoy", "*.rb")].sort.each { |file| require file }
Dir[File.join(__dir__, "podoy/validations", "*.rb")].sort.each { |file| require file }

module Podoy
  class Error < StandardError; end
end
