# frozen_string_literal: true

require "logger"

module Intacct
  # Configuration object for Intacct API credentials and settings.
  #
  # @attr sender_id [String] Intacct Web Services sender ID
  # @attr sender_password [String] Intacct Web Services sender password
  # @attr url [String] Custom API endpoint URL (optional)
  # @attr raise_exceptions [Boolean] Whether to raise exceptions on API errors (default: true)
  # @attr logger [Logger] Logger instance for debugging (default: ERROR level stdout logger)
  #
  # @example Basic configuration
  #   config = Intacct::Config.new
  #   config.sender_id = "my-sender-id"
  #   config.sender_password = "my-sender-password"
  #   config.raise_exceptions = false
  class Config
    attr_accessor :sender_id, :sender_password, :url, :raise_exceptions, :logger

    # Initialize a new configuration with default logger and exception handling
    #
    # @return [Config] a new configuration instance
    def initialize
      @logger = Logger.new($stdout, level: Logger::Severity::ERROR)
      @raise_exceptions = true
    end
  end
end
