module Intacct
  class FunctionResult
    attr_reader :status, :control_id, :xml_data

    def initialize(status, control_id, xml_data)
      @status = status
      @control_id = control_id
      @xml_data = xml_data
    end

    def successful?
      @status == 'success'
    end
  end
end
