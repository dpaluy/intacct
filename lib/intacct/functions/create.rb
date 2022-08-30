module Intacct
  module Functions
    class Create
      def initialize
        @record_blocks = []
      end

      def add_record(record_type, &block)
        @record_blocks << [record_type, block]
      end

      def to_xml
        builder = Builder::XmlMarkup.new

        builder.create do
          @record_blocks.each do |record_type, record_block|
            builder.tag!(record_type) do
              record_block.call(builder)
            end
          end
        end
      end
    end
  end
end

