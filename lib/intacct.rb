require_relative 'intacct/utils'
require_relative 'intacct/config'
require_relative 'intacct/gateway'
require_relative 'intacct/request'
require_relative 'intacct/functions/create'
require_relative 'intacct/functions/create_ar_adjustment'
require_relative 'intacct/functions/update'
require_relative 'intacct/functions/get_api_session'
require_relative 'intacct/functions/query'
require_relative 'intacct/functions/read'
require_relative 'intacct/functions/retrieve_pdf'
require_relative 'intacct/functions/reverse_payment'

module Intacct
  def self.logger
    config.logger
  end
end
