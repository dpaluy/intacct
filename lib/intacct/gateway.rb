require 'intacct/response'

module Intacct
  class Gateway
    URI_STRING = 'https://api.intacct.com/ia/xml/xmlgw.phtml'.freeze

    def initialize(control_config)
      @control_config = control_config
      @http_gateway = Net::HTTP.new(uri.host, uri.port)
      @http_gateway.use_ssl = true
    end

    def execute_request(api_request)
      post_request ||= Net::HTTP::Post.new(uri.request_uri)
      post_request['Content-Type'] = 'x-intacct-xml-request'
      post_request.body = api_request.to_xml(@control_config)
      puts post_request.body
      http_response = @http_gateway.request(post_request)

      Intacct::Response.new(http_response)
    end

    private

    def uri
      @uri ||= URI.parse(URI_STRING)
    end
  end
end
