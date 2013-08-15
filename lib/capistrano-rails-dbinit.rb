require "capistrano-rails-dbinit/version"

Capistrano::Configuration.instance.load do
  namespace :deploy do
    namespace :db do
      def run_rake(task)
        run "cd #{release_path} && bundle exec rake #{task} RAILS_ENV=#{rails_env}"
      end

      desc "Create Database"
      task :create, {:roles => :db, :only => {:primary => true}} do
        run_rake("db:create")
      end

      desc "Drop Database"
      task :drop, {:roles => :db, :only => {:primary => true}} do
        run_rake("db:drop")
      end

      desc "Load seed data"
      task :seed, {:roles => :db, :only => {:primary => true}} do
        run_rake("db:seed")
      end

      task :init, {:roles => :db, :only => {:primary => true}} do
        if ENV["FORCE_DEPLOY_DB_INIT"] == nil
          agree = Capistrano::CLI.ui.agree("deploy:db:init will DROP your database. Are you sure? (Yes, No)") do |q|
            q.default = 'No'
          end
        end

        transaction do
          deploy.update_code
          db.drop
          db.create
          deploy.migrate
          db.seed
        end
      end
    end
  end
end
