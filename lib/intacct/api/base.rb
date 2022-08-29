module Intacct
  module Api
    class Base
      attr_reader :client, :session

      def initialize(client:, session: nil)
        @client = client
        @session = session
      end

      def expired?
        session.nil? || session.expired?
      end
    end
  end
end
