module Intacct
  module Functions
    class GetApiSession
      def to_xml
        builder = Builder::XmlMarkup.new

        builder.getAPISession
      end
    end
  end
end
