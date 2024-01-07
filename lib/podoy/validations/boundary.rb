# frozen_string_literal: true

module Podoy
  module Validations
    module Boundary
      def validate_inclusion_of(value, boundary_array, message)
        unless boundary_array.include?(value)
          if message.nil?
            raise ArgumentError, "#{value} must be within #{boundary_array}"
          else
            raise ArgumentError, message
          end
        end
      end

      def validate_exclusion_of(value, boundary_array, message)
        if boundary_array.include?(value)
          if message.nil?
            raise ArgumentError, "#{value} must not be within #{boundary_array}"
          else
            raise ArgumentError, message
          end
        end
      end
    end
  end
end
