# frozen_string_literal: true

module Podoy
  class InOutDeclarator
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def input(name, type)
        define_method(name) do
          instance_variable_get("@#{name}")
        end

        define_method("#{name}=") do |value|
          validate_type(value, type)
          instance_variable_set("@#{name}", value)
        end
      end

      def output(name, type)
        define_method(name) do
          result = send(:call, Hash[name, instance_variable_get("@#{name}")])
          validate_type(result, type)
          instance_variable_set("@#{name}", result)
        end
      end

      private

      def validate_type(value, expected_type)
        unless value.is_a?(expected_type)
          raise ArgumentError, "#{value} is not of type #{expected_type}"
        end
      end
    end
  end
end

# class OrderDetails
#   def success?
#     true
#   end
# end

# class OrderStatus
#   attr_reader :shipped

#   def initialize(shipped:)
#     @shipped = shipped
#   end
# end

# class OrderShipment
#   include InOutDeclarator

#   input :order_details, OrderDetails
#   output :order_status, OrderStatus

#   def initialize; end

#   def call(inputs)
#     order_details = inputs[:order_details]

#     if order_details.success?
#       OrderStatus.new(shipped: true)
#     else
#       OrderStatus.new(shipped: false)
#     end
#   end
# end

# # Example usage
# order_shipment = OrderShipment.new
# order_shipment.order_details = OrderDetails.new
# order_shipment.order_status  # This will invoke the `call` method and set the `order_status` attribute
