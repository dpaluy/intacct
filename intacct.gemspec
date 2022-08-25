lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'intacct/version'

Gem::Specification.new do |spec|
  spec.name                  = 'intacct'
  spec.version               = Intacct::VERSION
  spec.authors               = ['David Paluy', 'Yaroslav Konovets']
  spec.required_ruby_version = '>= 2.2.0'
  spec.summary               = 'A Ruby wrapper for the Intacct API'
  spec.license               = 'MIT'

  spec.files                 = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'builder', '~> 3.0', '>= 3.0.4'
end
