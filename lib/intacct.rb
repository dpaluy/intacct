require 'intacct/request'
require 'intacct/gateway'
require 'intacct/query'

module Intacct
  VERSION = File.read(File.expand_path('../../VERSION', __FILE__)).strip.freeze
end
