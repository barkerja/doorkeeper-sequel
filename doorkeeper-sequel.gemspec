$:.push File.expand_path('../lib', __FILE__)

require 'doorkeeper-sequel/version'

Gem::Specification.new do |spec|
  spec.name          = 'doorkeeper-sequel'
  spec.version       = Doorkeeper::Sequel::VERSION
  spec.authors       = ['John Barker']
  spec.email         = ['jabarker1@gmail.com']

  spec.summary       = 'Doorkeeper Sequel ORM'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/barkerja/doorkeeper-sequel'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- spec/*`.split("\n")
  spec.require_paths = ['lib']

  spec.add_dependency 'doorkeeper', '>= 3.0.0'

  spec.add_development_dependency 'sqlite3', '~> 1.3.5'
  spec.add_development_dependency 'rspec-rails', '~> 3.4.0'
  spec.add_development_dependency 'capybara', '~> 2.3.0'
  spec.add_development_dependency 'generator_spec', '~> 0.9.0'
  spec.add_development_dependency 'factory_girl', '~> 4.5.0'
  spec.add_development_dependency 'timecop', '~> 0.7.0'
  spec.add_development_dependency 'database_cleaner', '~> 1.5.0'
end
