# frozen_string_literal: true

require_relative "intacct/version"
require_relative "intacct/utils"
require_relative "intacct/config"
require_relative "intacct/gateway"
require_relative "intacct/request"
require_relative "intacct/functions/create"
require_relative "intacct/functions/create_ar_adjustment"
require_relative "intacct/functions/update"
require_relative "intacct/functions/get_api_session"
require_relative "intacct/functions/query"
require_relative "intacct/functions/read"
require_relative "intacct/functions/retrieve_pdf"
require_relative "intacct/functions/reverse_payment"

module Intacct
  class << self
    # Returns the global configuration instance.
    #
    # @return [Config] the current configuration object
    def config
      @config ||= Config.new
    end

    # Configures the Intacct client globally.
    #
    # @example Configure with credentials
    #   Intacct.configure do |config|
    #     config.sender_id = ENV["INTACCT_SENDER_ID"]
    #     config.sender_password = ENV["INTACCT_SENDER_PASSWORD"]
    #     config.user_id = ENV["INTACCT_USER_ID"]
    #     config.user_password = ENV["INTACCT_USER_PASSWORD"]
    #     config.company_id = ENV["INTACCT_COMPANY_ID"]
    #   end
    #
    # @yield [config] Gives the configuration object to the block
    # @yieldparam config [Config] the configuration instance to modify
    # @return [void]
    def configure
      yield(config)
    end

    # Resets the global configuration to nil.
    #
    # Primarily used for testing to ensure a clean configuration state.
    #
    # @return [void]
    def reset_configuration!
      @config = nil
    end

    def logger
      config.logger
    end
  end
end
