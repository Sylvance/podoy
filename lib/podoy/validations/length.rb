# frozen_string_literal: true

module Podoy
  module Validations
    module Length
      def validate_minimum_length(value, minimum_check_value)
        if minimum_check_value && value.length < minimum_check_value
          raise ArgumentError, "#{value} must have a minimum length of #{minimum_check_value} characters"
        end
      end

      def validate_maximum_length(value, maximum_check_value)
        if maximum_check_value && value.length > maximum_check_value
          raise ArgumentError, "#{value} must have a maximum length of #{maximum_check_value} characters"
        end
      end

      def validate_equality_length(value, equality_check_value)
        if equality_check_value && value.length != equality_check_value
          raise ArgumentError, "#{value} must have exactly #{equality_check_value} characters"
        end
      end
    end
  end
end
