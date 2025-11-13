# frozen_string_literal: true

module Intacct
  class FunctionResult
    attr_reader :status, :control_id, :xml_data

    def initialize(xml_entry)
      @status = xml_entry.xpath("status").text
      @control_id = xml_entry.xpath("controlid").text
      @xml_data = xml_entry
    end

    def successful?
      @status == "success"
    end

    def parsed_data
      hash = Crack::XML.parse(@xml_data.to_s).with_indifferent_access
      successful? ? hash.fetch("result") : hash
    end

    def push_error_messages
      error_details = parsed_data.dig(:result, :errormessage, :error)

      error_details = [error_details] unless error_details.is_a?(Array)

      error_details.compact.map do |error_data|
        [error_data[:description2], error_data[:correction]].compact.join(" ")
      end
    end
  end
end
