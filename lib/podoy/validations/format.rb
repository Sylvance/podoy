# frozen_string_literal: true

module Podoy
  module Validations
    module Format
      def validate_format_of(value, format_regex)
        unless value =~ format_regex
          raise ArgumentError, "#{value} does not match the expected format"
        end
      end
    end
  end
end
