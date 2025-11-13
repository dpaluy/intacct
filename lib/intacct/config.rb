# frozen_string_literal: true

require "logger"

module Intacct
  class Config
    attr_accessor :sender_id, :sender_password, :url, :raise_exceptions, :logger

    def initialize
      @logger = Logger.new($stdout, level: Logger::Severity::ERROR)
      @raise_exceptions = true
    end
  end
end
