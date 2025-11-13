# frozen_string_literal: true

module Intacct
  module Functions
    class RetrievePdf
      def build_query(&block)
        @query_block = block
      end

      def to_xml
        builder = Builder::XmlMarkup.new
        builder.retrievepdf do
          @query_block.call(builder) if @query_block.present?
        end
      end
    end
  end
end
