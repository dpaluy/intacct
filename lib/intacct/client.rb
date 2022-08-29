require 'faraday'
require 'exceptions/client_exception'

module Intacct
  class Client
    URL = 'https://api.intacct.com'.freeze
    DEFAULT_ENDPOINT = 'ia/xml/xmlgw.phtml'.freeze
    HEADERS = { 'Content-Type' => 'application/xml' }.freeze # x-intacct-xml-request

    attr_reader :key, :secret, :uri, :user_agent, :raise_exceptions
    attr_writer :adapter, :conn

    # rubocop:disable Metrics/AbcSize
    def initialize(params = {})
      @key    = params.fetch(:sender_id, Intacct.config.sender_id)
      @secret = params.fetch(:sender_password, Intacct.config.secret)
      @url    = params.fetch(:url, Intacct.config.url || URL)
      @raise_exceptions = params.fetch(:raise_exceptions,
                                       Intacct.config.raise_exceptions)
      @adapter    = params.fetch(:adapter, adapter)
      @conn       = params.fetch(:conn, conn)
      @user_agent = params.fetch(:user_agent, "intacct/#{Intacct::VERSION};ruby")
      yield self if block_given?
    end
    # rubocop:enable Metrics/AbcSize

    def post(request:, endpoint: DEFAULT_ENDPOINT, headers: {})
      response = conn.post(endpoint) do |req|
        req.headers = HEADERS.merge('User-Agent' => user_agent).deep_merge(headers)
        req.body = request.to_xml
      end
      raise Intacct::ClientException, response.body if raise_exceptions? && response.status != 200

      response
    end

    def conn
      @conn ||= Faraday.new(url: url) do |conn|
        conn.request :url_encoded
        conn.adapter adapter
      end
    end

    def adapter
      @adapter ||= Faraday.default_adapter
    end

    def raise_exceptions?
      @raise_exceptions
    end
  end
end
