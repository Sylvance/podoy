# frozen_string_literal: true

module Podoy
  class Result
    attr_reader :value, :error

    def initialize(value, error = nil)
      @value = value
      @error = error
    end

    def success?
      @error.nil?
    end

    def self.try(default = nil, &block)
      new(yield)
    rescue StandardError => e
      new(default || yield, e)
    end
  end
end

# This module makes it easier to simple processes while making the code look clean:
#
# module Arithmetic
#   module Errors
#     # Custom error class for division by zero
#     class DivisionByZeroError < StandardError
#       def initialize(message = "Division by zero is not allowed")
#         super(message)
#       end
#     end

#     # Custom error class for invalid numbers
#     class InvalidNumberError < StandardError
#       def initialize(message = "Invalid numbers provided for arithmetic operation")
#         super(message)
#       end
#     end
#   end

#   module Validations
#     # Validation method for division by zero
#     def validate_division_by_zero(b)
#       raise Errors::DivisionByZeroError if b.zero?
#     end

#     # Validation method for invalid numbers
#     def validate_invalid_numbers(*numbers)
#       invalid_numbers = numbers.reject { |num| [Integer, Float].include?(num.class) }
#       raise Errors::InvalidNumberError unless invalid_numbers.empty?
#     end
#   end

#   class Calculator
#     extend Validations

#     class Result
#       attr_reader :value, :error

#       def initialize(value, error = nil)
#         @value = value
#         @error = error
#       end

#       def success?
#         @error.nil?
#       end

#       def self.try
#         new(yield)
#       rescue StandardError => e
#         new(nil, e)
#       end
#     end

#     def self.divide(a, b)
#       Result.try do
#         validate_division_by_zero(b)
#         validate_invalid_numbers(a, b)

#         a / b
#       end
#     end

#     def self.multiply(a, b)
#       Result.try do
#         validate_invalid_numbers(a, b)

#         a * b
#       end
#     end

#     def self.add(a, b)
#       Result.try do
#         validate_invalid_numbers(a, b)

#         a + b
#       end
#     end

#     def self.subtract(a, b)
#       Result.try do
#         validate_invalid_numbers(a, b)

#         a - b
#       end
#     end
#   end
# end

# # Example usage
# result_addition = Arithmetic::Calculator.add(5, 3)
# result_subtraction = Arithmetic::Calculator.subtract(10, 4)
# result_multiplication = Arithmetic::Calculator.multiply(7, 2)
# result_division = Arithmetic::Calculator.divide(20, 5)

# puts "Addition Result: #{result_addition.value}" if result_addition.success?
# puts "Subtraction Result: #{result_subtraction.value}" if result_subtraction.success?
# puts "Multiplication Result: #{result_multiplication.value}" if result_multiplication.success?
# puts "Division Result: #{result_division.value}" if result_division.success?
