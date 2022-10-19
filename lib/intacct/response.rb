require 'intacct/function_result'


module Intacct
  class Response
    attr_reader :response_body

    def initialize(http_response)
      @response_body = Nokogiri::XML(http_response.body)

      # raises an error unless the response is in the 2xx range.
      http_response.value
    end

    def successful?
      @response_body.xpath('//response/control/status').text == 'success'
    end

    def get_function_result(control_id)
      @function_results ||= build_function_results
      @function_results[control_id.to_s]
    end

    private

    def build_function_results
      @response_body.xpath("//result").map do |xml_entry|
        function_result = Intacct::FunctionResult.new(xml_entry)

        [function_result.control_id, function_result]
      end.to_h
    end
  end
end
