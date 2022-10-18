module Intacct
  module Utils
    YEAR_FORMAT = "%Y".freeze
    MONTH_FORMAT = "%m".freeze
    DAY_FORMAT = "%d".freeze
    DATE_FORMAT = "#{MONTH_FORMAT}/#{DAY_FORMAT}/#{YEAR_FORMAT}".freeze
    DATETIME_FORMAT = "#{MONTH_FORMAT}/#{DAY_FORMAT}/#{YEAR_FORMAT} %H:%M:%S".freeze

    def self.format_date(date)
      date&.strftime(DATE_FORMAT)
    end

    def self.format_datetime(datetime)
      datetime&.strftime(DATETIME_FORMAT)
    end

    def self.format_year(date)
      date.strftime(YEAR_FORMAT)
    end

    def self.format_month(date)
      date.strftime(MONTH_FORMAT)
    end

    def self.format_day(date)
      date.strftime(DAY_FORMAT)
    end

    def self.parse_date(date)
      Date.strptime(date, DATE_FORMAT)
    end

    def self.parse_datetime(datetime)
      DateTime.strptime(datetime, DATETIME_FORMAT)
    end
  end
end
