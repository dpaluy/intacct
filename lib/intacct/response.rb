require 'intacct/function_result'


module Intacct
  class Response
    attr_reader :response_body

    def initialize(http_response)
      @response_body = Nokogiri::XML(http_response.body)

      # raises an error unless the response is in the 2xx range.
      http_response.value
    end

    def function_errors
      @function_errors ||= @response_body.xpath('//error/description2').map(&:text)
    end

    def successful?
      function_errors.none?
    end

    def get_function_result(function_key)
      @function_results ||= build_function_results
      @function_results[function_key]
    end

    private

    def build_function_results
      @response_body.xpath("//result").map do |xml_entry|
        response_status = xml_entry.xpath('status').text
        data = response_status == 'success' ? xml_entry.xpath('data') : xml_entry.xpath('error')
        function_result = Intacct::FunctionResult.new(response_status, xml_entry.xpath('controlid').text, data)

        [function_result.control_id, function_result]
      end.to_h
    end
  end
end
