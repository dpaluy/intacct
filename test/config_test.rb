# frozen_string_literal: true

require "test_helper"

class ConfigTest < Minitest::Test
  include Intacct::TestHelper

  def test_config_attributes
    config = Intacct::Config.new

    config.sender_id = "sender"
    config.sender_password = "pass"
    config.url = "https://custom.url"

    assert_equal "sender", config.sender_id
    assert_equal "pass", config.sender_password
    assert_equal "https://custom.url", config.url
  end

  def test_default_logger
    config = Intacct::Config.new
    assert_instance_of Logger, config.logger
  end

  def test_default_raise_exceptions
    config = Intacct::Config.new
    assert_equal true, config.raise_exceptions
  end

  def test_custom_logger
    custom_logger = Logger.new($stdout)
    config = Intacct::Config.new
    config.logger = custom_logger
    assert_equal custom_logger, config.logger
  end
end
