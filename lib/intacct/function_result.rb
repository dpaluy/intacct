module Intacct
  class FunctionResult
    attr_reader :status, :control_id, :xml_data

    def initialize(xml_entry)
      @status = xml_entry.xpath('status').text
      @control_id = xml_entry.xpath('controlid').text
      @xml_data = xml_entry
    end

    def successful?
      @status == 'success'
    end

    def parsed_data
      hash = Crack::XML.parse(@xml_data.to_s)
      successful? ? hash.fetch('result') : hash
    end
  end
end
