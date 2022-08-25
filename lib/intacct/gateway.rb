require 'intacct/response'

module Intacct
  class Gateway
    URI_STRING = 'https://api.intacct.com/ia/xml/xmlgw.phtml'.freeze

    def initialize(opts)
      @opts = opts
    end

    def execute_query(query)
      request = Intacct::Request.new(@opts)
      request.add_content_block([query])

      post_request ||= Net::HTTP::Post.new(uri.request_uri)
      post_request['Content-Type'] = 'x-intacct-xml-request'
      post_request.body = request.to_xml
      puts request.to_xml
      Intacct::Response.new(https_request(post_request, uri))
    end

    def execute_functions(functions)
      # TODO
    end

    private

    def uri
      @uri ||= URI.parse URI_STRING
    end

    def https_request(request, uri)
      @http_gateway ||= Net::HTTP.new uri.host, uri.port
      @http_gateway.use_ssl = true
      @http_gateway.request request
    end
  end
end
