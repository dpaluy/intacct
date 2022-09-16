module Intacct
  module Functions
    class RetrievePdf
      def build_query(&block)
        @query_block = block
      end

      def to_xml
        builder = Builder::XmlMarkup.new
        builder.retrievepdf do
          if @query_block.present?
            @query_block.call(builder)
          end
        end
      end
    end
  end
end

