# Capistrano::Rails::Dbinit

Capistrano tasks to initialize database for Rails Apps

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-rails-dbinit'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-rails-dbinit

## Usage

load capistrano-rails-dbinit in your config/deploy.rb:

    require 'capistrano-rails-dbinit'

And then, run capistrano-task *deploy:db:init*

    $ cap deploy:db:init

capistrano-rails-dbinit will initialize your database specified from :rails_env.
The task calls these tasks on execution:

- deploy:update_code
- deploy:create_symlink
- db:symlink (capistrano_database_yml)
- deploy:db:drop
- deploy:db:create
- deploy:migrate
- deploy:db:seed

NOTICE: capistrano-rails-dbinit ignores all callbacks (after/before hooks)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
