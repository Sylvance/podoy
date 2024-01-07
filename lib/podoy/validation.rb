# frozen_string_literal: true

module Podoy
  module Validation
    include Podoy::Validations::Boundary
    include Podoy::Validations::Comparison
    include Podoy::Validations::Format
    include Podoy::Validations::Length

    def validate(value, options = {})
      validate_type(value, options[:type]) if options[:type]
      validate_comparison(value, options[:comparison]) if options[:comparison]
      validate_numericality(value, options[:numericality]) if options[:numericality]
      validate_format(value, options[:format]) if options[:format]
      validate_length(value, options[:length]) if options[:length]
      validate_inclusion(value, options[:inclusion]) if options[:inclusion]
      validate_exclusion(value, options[:exclusion]) if options[:exclusion]
    end

    private

    def validate_type(value, type)
      raise ArgumentError, "#{value} must be a #{type}" unless value.is_a?(type)
    end

    def validate_comparison(value, options)
      if options[:equality]
        check_for_equality(value, options[:equality])
      end

      if options[:greater_than]
        check_for_greater_than(value, options[:greater_than])
      end

      if options[:less_than]
        check_for_less_than(value, options[:less_than])
      end

      if options[:greater_than_or_equal_to]
        check_for_greater_than_or_equal_to(value, options[:greater_than_or_equal_to])
      end

      if options[:less_than_or_equal_to]
        check_for_less_than_or_equal_to(value, options[:less_than_or_equal_to])
      end
    end

    def validate_numericality(value, options)
      if options[:only_integer] == true
        validate_type(value, Integer)
      end
    end

    def validate_format(value, options)
      if options[:with]
        validate_format_of(value, options[:with])
      end
    end

    def validate_length(value, options)
      if options[:minimum]
        validate_minimum_length(value, options[:minimum])
      end

      if options[:maximum]
        validate_maximum_length(value, options[:maximum])
      end

      if options[:equality]
        validate_equality_length(value, options[:equality])
      end
    end

    def validate_inclusion(value, options)
      if options[:in]
        validate_inclusion_of(value, options[:in], options[:message])
      end
    end

    def validate_exclusion(value, options)
      if options[:in]
        validate_exclusion_of(value, options[:in], options[:message])
      end
    end
  end
end

# A = Struct.new(:a, :b, :c, :d) do
#   include Validation
#
#   def initialize(a:, b: 'bo', c: 'small', d: 'ke')
#     validate(a, type: Integer, comparison: { greater_than: 5 }, numericality: { only_integer: true })
#     validate(b, type: String, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }, length: { minimum: 2 })
#     validate(c, type: String, inclusion: { in: %w(small medium large), message: "%{value} is not a valid size" })
#     validate(d, type: String, exclusion: { in: %w(www us ca jp), message: "%{value} is reserved." }, length: { maximum: 3, too_long: "%{count} characters is the maximum allowed" })
#
#     super(a, b, c, d)
#   end
# end
#
# # Example usage:
# begin
#   instance = A.new(a: 6, b: 'book', c: 'medium', d: 'xyz')
#   puts "Struct instance created successfully: #{instance.inspect}"
# rescue ArgumentError => e
#   puts "Error creating struct instance: #{e.message}"
# end
