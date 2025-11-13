# frozen_string_literal: true

require_relative "lib/intacct/version"

Gem::Specification.new do |spec|
  spec.name = "intacct"
  spec.version = Intacct::VERSION
  spec.authors = ["David Paluy", "Yaroslav Konovets"]
  spec.required_ruby_version = ">= 3.2.0"
  spec.summary = "A Ruby wrapper for the Intacct API"
  spec.license = "MIT"

  spec.homepage = "https://github.com/dpaluy/intacct"
  spec.metadata["rubygems_mfa_required"] = "true"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["documentation_uri"] = "https://rubydoc.info/gems/intacct"
  spec.metadata["source_code_uri"] = "https://github.com/dpaluy/intacct"
  spec.metadata["changelog_uri"] = "https://github.com/dpaluy/intacct/blob/master/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "https://github.com/dpaluy/intacct/issues"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ .github/ .gitignore .rspec .rubocop.yml Gemfile])
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.extra_rdoc_files = Dir["README.md", "CHANGELOG.md", "LICENSE.txt"]

  spec.add_dependency "builder", "~> 3.0"

  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rubocop", "~> 1.21"
  spec.add_development_dependency "webmock", "~> 3.23"
  spec.add_development_dependency "yard", "~> 0.9"
end
