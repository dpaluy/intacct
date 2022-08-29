require_relative 'intacct/config'
require_relative 'intacct/gateway'
require_relative 'intacct/request'
require_relative 'intacct/functions/get_api_session'
require_relative 'intacct/functions/query'

module Intacct
  def self.logger
    config.logger
  end
end
