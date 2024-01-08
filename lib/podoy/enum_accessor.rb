# frozen_string_literal: true

module Podoy
  module EnumAccessor
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def enum_accessor(attribute, *values)
        # Define the getter method
        define_method(attribute.to_s) do
          instance_variable_get("@#{attribute.to_s}")
        end

        # Define the setter method
        define_method("#{attribute.to_s}=") do |value|
          instance_variable_set("@#{attribute.to_s}", value)
        end

        struct_name = attribute.to_s.split('_').map(&:capitalize).join

        # Define the Struct
        struct_class = Struct.new(:name, :value) do
          const_set("#{attribute.to_s.upcase}_VALUES", values.map(&:to_s).freeze)

          def self.create(name)
            raise ArgumentError, "Invalid enum value" unless const_get("#{attribute.to_s.upcase}_VALUES").include?(name.upcase)

            self.new(name, const_get("#{attribute.to_s.upcase}_VALUES").index(name.upcase))
          end

          const_get("#{attribute.to_s.upcase}_VALUES").each do |status|
            define_method("#{status.downcase}?") do
              self.name.upcase == status
            end
          end
        end

        const_set(struct_name, struct_class)

        values_hash = values.each_with_object({}).with_index { |(value, hash), i| hash[value] = i }
        values_hash.each do |name, _|
          define_method("#{name.upcase}") { self.class.const_get(struct_name).create(name) }
        end
      end
    end
  end
end

# class TrafficLight
#   include EnumAccessor

#   enum_accessor :color, :red, :yellow, :green
# end

# # Creating an instance of the class
# traffic_light = TrafficLight.new

# # Setting the color
# traffic_light.color = :green

# # Getting the color
# puts traffic_light.color # Output: green

# # Checking the color using predicate methods
# puts traffic_light.red?    # Output: false
# puts traffic_light.yellow? # Output: false
# puts traffic_light.green?  # Output: true

# # Creating instances of the enum values
# red_light = TrafficLight::Red.new
# puts red_light.name  # Output: red
# puts red_light.value # Output: 0

# OR:
# It is similar to creating a struct that looks like this
# this struct works like an enum:
#
# OrderStatus = Struct.new(:name, :value) do
#   VALID_VALUES = ["PENDING", "SHIPPED", "DELIVERED", "CANCELLED"].freeze

#   def self.create(name)
#     raise ArgumentError, "Invalid enum value" unless VALID_VALUES.include?(name.upcase)

#     self.new(name, VALID_VALUES.index(name.upcase))
#   end

#   def pending?
#     self.name.upcase == 'PENDING'
#   end

#   def shipped?
#     self.name.upcase == 'SHIPPED'
#   end

#   def delivered?
#     self.name.upcase == 'DELIVERED'
#   end

#   def cancelled?
#     self.name.upcase == 'CANCELLED'
#   end
# end

# PENDING  = OrderStatus.create("pending") # => #<struct OrderStatus name="pending", value=0>
# SHIPPED  = OrderStatus.create("shipped") # => #<struct OrderStatus name="shipped", value=1>
# DELIVERED = OrderStatus.create("delivered") # => #<struct OrderStatus name="delivered", value=2>
# CANCELLED = OrderStatus.create("cancelled") # => #<struct OrderStatus name="cancelled", value=3>

# class Order
#   include EnumAccessor

#   enum_accessor :order_status, :pending, :shipped, :delivered, :cancelled

#   def initialize; end
# end

# Order.new
