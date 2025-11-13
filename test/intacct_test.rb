# frozen_string_literal: true

require "test_helper"

class IntacctTest < Minitest::Test
  def test_has_version_number
    refute_nil Intacct::VERSION
    assert_match(/\d+\.\d+\.\d+/, Intacct::VERSION)
  end

  def test_configure_yields_config
    Intacct.configure do |config|
      assert_instance_of Intacct::Config, config
    end
  end

  def test_reset_configuration
    Intacct.configure do |config|
      config.sender_id = "test-id"
    end

    assert_equal "test-id", Intacct.config.sender_id

    Intacct.reset_configuration!

    assert_nil Intacct.config.sender_id
  end
end
