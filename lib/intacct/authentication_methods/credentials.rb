require 'builder'

module Intacct
  module AuthenticationMethods
    class Credentials
      def initialize(user_id:, company_id:, password:)
        @user_id = user_id
        @company_id = company_id
        @password = password
      end

      def to_xml
        builder = Builder::XmlMarkup.new

        builder.login do
          builder.userid @user_id
          builder.companyid @company_id
          builder.password @password
        end
      end
    end
  end
end
