# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'db_bot/version'

Gem::Specification.new do |spec|
  spec.name          = "db_bot"
  spec.version       = DbBot::VERSION
  spec.authors       = ["William Porter"]
  spec.email         = ["willports@gmail.com"]
  spec.summary       = "Bot to interact with your database using plain english"
  spec.description   = "DB Bot uses Natural Language Processing (NLP) to construct DB queries. What that means is you can interact with your database like you're talking to a human"
  spec.homepage      = "https://github.com/dawilster"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", "~> 4.2.0"
  spec.add_dependency "activesupport", "~> 4.2.0"
  spec.add_dependency "wit", "~> 4.1.0"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-activemodel-mocks", "~> 1.0"
  spec.add_development_dependency "awesome_print"
end
