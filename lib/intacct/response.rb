# frozen_string_literal: true

require "intacct/function_result"
require "intacct/authentication_result"

module Intacct
  # Parses and provides access to Intacct API XML responses.
  #
  # Wraps the HTTP response from Intacct and provides convenient methods
  # to check status and extract function results.
  #
  # @example Parse a response
  #   response = Intacct::Response.new(http_response)
  #   if response.successful?
  #     result = response.get_function_result("my-control-id")
  #     puts result.data
  #   end
  class Response
    # @return [Nokogiri::XML::Document] the parsed XML response body
    attr_reader :response_body

    # Initialize a new Response from an HTTP response
    #
    # @param http_response [Net::HTTPResponse] the HTTP response from Intacct API
    # @raise [Net::HTTPError] if the response status is not 2xx
    def initialize(http_response)
      @response_body = Nokogiri::XML(http_response.body)

      # raises an error unless the response is in the 2xx range.
      http_response.value
    end

    # Check if the overall response was successful
    #
    # @return [Boolean] true if the response control status is "success"
    def successful?
      @response_body.xpath("//response/control/status").text == "success"
    end

    # Get the function result for a specific control ID
    #
    # @param control_id [String, Symbol] the control ID of the function
    # @return [FunctionResult, nil] the function result or nil if not found
    def get_function_result(control_id)
      @function_results ||= build_function_results
      @function_results[control_id.to_s]
    end

    # Get the authentication result from the response
    #
    # @return [AuthenticationResult] the authentication result
    def get_authentication_result
      Intacct::AuthenticationResult.new(@response_body.xpath("//response/operation/authentication"))
    end

    private

    def build_function_results
      @response_body.xpath("//result").to_h do |xml_entry|
        function_result = Intacct::FunctionResult.new(xml_entry)

        [function_result.control_id, function_result]
      end
    end
  end
end
