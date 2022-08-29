require_relative 'intacct/config'
require_relative 'intacct/client'
require_relative 'intacct/request'
require_relative 'intacct/query'

module Intacct
  VERSION = File.read(File.expand_path('../../VERSION', __FILE__)).strip.freeze

  def self.logger
    config.logger
  end
end
