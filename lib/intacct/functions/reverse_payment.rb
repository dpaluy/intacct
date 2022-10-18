module Intacct
  module Functions
    class ReversePayment
      def initialize(key, &block)
        @key = key
        @block = block
      end

      def to_xml
        builder = Builder::XmlMarkup.new
        builder.reverse_arpayment(key: @key) do
          @block.call(builder)
        end
      end
    end
  end
end
