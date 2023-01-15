module Intacct
  class AuthenticationResult
    attr_reader :status, :xml_data

    def initialize(xml_entry)
      @status = xml_entry.xpath('status').text
      @xml_data = xml_entry
    end

    def successful?
      @status == 'success'
    end

    def parsed_data
      Crack::XML.parse(@xml_data.to_s)
    end
  end
end
