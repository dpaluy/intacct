module Intacct
  module Utils
    DATE_FORMAT = "%m/%d/%Y".freeze
    DATETIME_FORMAT = "%m/%d/%Y %H:%M:%S".freeze

    def self.format_date(date)
      date&.strftime(DATE_FORMAT)
    end

    def self.format_datetime(datetime)
      datetime&.strftime(DATETIME_FORMAT)
    end

    def self.parse_date(date)
      Date.strptime(date, DATE_FORMAT)
    end

    def self.parse_datetime(datetime)
      DateTime.strptime(datetime, DATETIME_FORMAT)
    end
  end
end
