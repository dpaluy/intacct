require 'intacct/function_result'


module Intacct
  class Response
    attr_reader :response_body

    def initialize(http_response)
      @response_body = Nokogiri::XML(http_response.body)

      # raises an error unless the response is in the 2xx range.
      http_response.value

      # in case the response is a success, but one of the included functions
      # failed and the transaction was rolled back
      raise_function_errors unless successful?
    end

    def function_errors
      @function_errors ||= @response_body.xpath('//error/description2').map(&:text)
    end

    def successful?
      function_errors.none?
    end

    def get_function_result(function_key)
      return unless successful?

      @function_results ||= build_function_results
      @function_results[function_key]
    end

    private

    def raise_function_errors
      raise Exceptions::FunctionFailureException, function_errors.join("\n")
    end

    def build_function_results
      @response_body.xpath("//result").map do |xml_entry|
        function_result = Intacct::FunctionResult.new(
          xml_entry.xpath('status').text, xml_entry.xpath('controlid').text, xml_entry.xpath('data')
        )

        [function_result.control_id, function_result]
      end.to_h
    end
  end
end
