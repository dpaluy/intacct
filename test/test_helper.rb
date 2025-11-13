# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "intacct"

require "minitest/autorun"
require "webmock/minitest"

# Disable external HTTP requests
WebMock.disable_net_connect!(allow_localhost: true)

module Intacct
  module TestHelper
    def setup
      WebMock.reset!
      Intacct.reset_configuration!
    end

    def teardown
      WebMock.reset!
      Intacct.reset_configuration!
    end

    def configure_intacct
      Intacct.configure do |config|
        config.sender_id = "test-sender-id"
        config.sender_password = "test-sender-password"
        config.user_id = "test-user-id"
        config.user_password = "test-user-password"
        config.company_id = "test-company"
      end
    end

    def stub_successful_intacct_request(response_body: "<success/>")
      stub_request(:post, "https://api.intacct.com/ia/xml/xmlgw.phtml")
        .to_return(status: 200, body: response_body, headers: { "Content-Type" => "text/xml" })
    end
  end
end
