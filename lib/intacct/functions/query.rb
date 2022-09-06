module Intacct
  module Functions
    class Query
      def initialize(object, fields:, **args)
        @object = object
        @fields = fields
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
        end
      end
    end
  end
end

