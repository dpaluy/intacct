module Intacct
  module Functions
    class Read
      attr_reader :object, :keys, :fields, :args

      def initialize(object, keys:, fields:, **args)
        @object = object
        @keys = keys
        @fields = fields
        @args = args
      end

      def to_xml
        builder = Builder::XmlMarkup.new
        builder.read do
          builder.object @object
          builder.keys keys.join(',')
          if @fields.any?
            fields.each { |field| builder.field field }
          else
            builder.fields '*'
          end
          args.each do |key, value|
            builder.tag!(key, value)
          end
        end
      end
    end
  end
end
