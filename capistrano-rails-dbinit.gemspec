# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano-rails-dbinit/version'

Gem::Specification.new do |gem|
  gem.name          = "capistrano-rails-dbinit"
  gem.version       = Capistrano::Rails::Dbinit::VERSION
  gem.authors       = ["Takeshi KOMIYA"]
  gem.email         = ["i.tkomiya@gmail.com"]
  gem.description   = "Capistrano tasks to initialize database for Rails Apps"
  gem.summary       = "Capistrano tasks to initialize database for Rails Apps"
  gem.homepage      = "https://github.com/tk0miya/capistrano-rails-dbinit"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "capistrano"
  gem.add_dependency "capistrano_database_yml"
end
