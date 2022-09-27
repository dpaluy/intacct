module Intacct
  module Functions
    class Create
      def initialize(record_type, &block)
        @record_type = record_type
        @block = block
      end

      def to_xml
        builder = Builder::XmlMarkup.new

        builder.create do
          builder.tag!(@record_type) do
            @block.call(builder)
          end
        end
      end
    end
  end
end
