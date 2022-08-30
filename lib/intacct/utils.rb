module Intacct
  module Utils
    def self.format_date(date)
      date.strftime("%m/%d/%Y")
    end

    def self.format_datetime(datetime)
      datetime.strftime("%m/%d/%Y %H:%M:%S")
    end
  end
end
