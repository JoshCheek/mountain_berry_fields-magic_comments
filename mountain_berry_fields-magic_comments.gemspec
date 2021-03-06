# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["Josh Cheek"]
  gem.email         = ["josh.cheek@gmail.com"]
  gem.description   = %q{Test code samples embedded in files like readmes}
  gem.summary       = %q{Test code samples embedded in files like readmes}
  gem.homepage      = "https://github.com/JoshCheek/mountain_berry_fields-magic_comments"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |file| File.basename file }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mountain_berry_fields-magic_comments"
  gem.require_paths = ["lib"]
  gem.version       = '1.0.2'

  gem.add_runtime_dependency 'seeing_is_believing',   '~> 2.1'
  gem.add_runtime_dependency 'deject',                '~> 0.2.2'
  gem.add_runtime_dependency 'mountain_berry_fields', '~> 1.0.2'

  gem.add_development_dependency 'surrogate',         '~> 0.8.0'
  gem.add_development_dependency 'rspec',             '~> 3.0'
  gem.add_development_dependency 'cucumber',          '~> 1.3.16'
  gem.add_development_dependency 'rake'
end
