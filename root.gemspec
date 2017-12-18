# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "root/version"

Gem::Specification.new do |spec|
  spec.name          = "root"
  spec.version       = Root::VERSION
  spec.authors       = ["Martin Pretorius"]
  spec.email         = ["glasnoster@gmail.com"]

  spec.summary       = "Root API client"
  spec.description   = "Root API client"
  spec.homepage      = "https://github.com/RootBank/root-ruby"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty'
  spec.add_dependency 'tty-table'
  spec.add_runtime_dependency "highline", "~> 1.6"

  spec.add_development_dependency "semvergen", "~> 1.9"
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 3.1.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency 'pry-byebug', "~> 2.0"
  spec.add_development_dependency 'pry-stack_explorer', "~> 0.4"
  spec.add_development_dependency 'pry-rescue', "~> 1.4"

end
