# frozen_string_literal: true

module Intacct
  module Functions
    class GetApiSession
      def initialize(location_id: nil)
        @location_id = location_id
      end

      def to_xml
        builder = Builder::XmlMarkup.new

        if @location_id.present?
          builder.getAPISession do
            builder.locationid @location_id
          end
        else
          builder.getAPISession
        end
      end
    end
  end
end
