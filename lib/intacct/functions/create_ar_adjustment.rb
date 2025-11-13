# frozen_string_literal: true

module Intacct
  module Functions
    class CreateArAdjustment
      def initialize(&block)
        @block = block
      end

      def to_xml
        builder = Builder::XmlMarkup.new

        builder.create_aradjustment do
          @block.call(builder)
        end
      end
    end
  end
end
