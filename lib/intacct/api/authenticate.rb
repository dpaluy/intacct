module Intacct
  module Api
    class Authenticate < Base
      def generate_session(opts)
        request = Intacct::Request.new(senderid: client.key, password: client.secret)
        request.add_content_block()
      end

      private

      def authentication_block

      end
    end
  end
end
