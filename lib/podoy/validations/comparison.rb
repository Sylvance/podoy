# frozen_string_literal: true

module Podoy
  module Validations
    module Comparison
      def check_for_equality(value, checked_value)
        raise ArgumentError, "#{value} must be equal to #{checked_value}" unless value == checked_value
      end

      def check_for_greater_than(value, checked_value)
        raise ArgumentError, "#{value} must be greater than #{checked_value}" unless value > checked_value
      end

      def check_for_less_than(value, checked_value)
        raise ArgumentError, "#{value} must be less than #{checked_value}" unless value < checked_value
      end

      def check_for_greater_than_or_equal_to(value, checked_value)
        raise ArgumentError, "#{value} must be greater than #{checked_value}" unless value >= checked_value
      end

      def check_for_less_than_or_equal_to(value, checked_value)
        raise ArgumentError, "#{value} must be less than #{checked_value}" unless value <= checked_value
      end
    end
  end
end
