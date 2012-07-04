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
  gem.version       = '1.0.0'

  gem.add_runtime_dependency 'rcodetools',                '~> 0.8.5.0'
  gem.add_runtime_dependency 'deject',                    '~> 0.2.2'

  gem.add_development_dependency 'mountain_berry_fields', '~> 1.0.0'
  gem.add_development_dependency 'surrogate',             '~> 0.5.1'
  gem.add_development_dependency 'rspec',                 '~> 2.10.0'
  gem.add_development_dependency 'cucumber',              '~> 1.2.0'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'pry'
end
