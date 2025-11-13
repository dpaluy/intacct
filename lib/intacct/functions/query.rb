# frozen_string_literal: true

module Intacct
  module Functions
    class Query
      def initialize(object, fields:, order: {}, case_insensitive: true, **args)
        @object = object
        @fields = fields
        @order = order
        @case_insensitive = case_insensitive
        @args = args
      end

      def add_filter(&block)
        @filter_block = block
      end

      def to_xml
        builder = Builder::XmlMarkup.new
        builder.query do
          builder.object @object
          if @fields.any?
            builder.select do
              @fields.each do |field|
                builder.field field
              end
            end
          end

          if @filter_block.present?
            builder.filter do
              @filter_block.call(builder)
            end
          end

          @args.each do |key, value|
            builder.tag!(key, value)
          end

          if @order.present?
            builder.orderby do
              @order.each do |attribute, direction|
                builder.order do
                  builder.field attribute
                  builder.tag!(to_direction(direction))
                end
              end
            end
          end

          builder.options do
            builder.caseinsensitive(@case_insensitive)
          end
        end
      end

      private

      def to_direction(direction)
        case direction
        when :asc
          "ascending"
        when :desc
          "descending"
        else
          raise ArgumentError, "Invalid direction: #{direction}"
        end
      end
    end
  end
end
