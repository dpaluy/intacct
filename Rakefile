# frozen_string_literal: true

require "bundler/gem_tasks"
require "minitest/test_task"

Minitest::TestTask.create

require "rubocop/rake_task"
RuboCop::RakeTask.new

begin
  require "yard"
  YARD::Rake::YardocTask.new do |t|
    t.files = ["lib/**/*.rb"]
    t.options = ["--markup", "markdown", "--no-private"]
  end
rescue LoadError
  # YARD not available
end

task default: %i[test rubocop]
