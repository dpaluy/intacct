require 'builder'

module Intacct
  module AuthenticationMethods
    class Session
      def initialize(session_token)
        @session_token = session_token
      end

      def to_xml
        builder = Builder::XmlMarkup.new

        builder.sessionid @session_token
      end
    end
  end
end
