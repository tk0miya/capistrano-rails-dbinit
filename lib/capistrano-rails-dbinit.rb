require "capistrano-rails-dbinit/version"

Capistrano::Configuration.instance.load do
  namespace :deploy do
    namespace :db do
      def run_rake(task)
        run "cd #{current_path} && bundle exec rake #{task} RAILS_ENV=#{rails_env}"
      end

      desc "Create Database"
      task :create, {:roles => :db, :only => {:primary => true}} do
        run_rake("db:create")
      end

      desc "Create Database"
      task :drop, {:roles => :db, :only => {:primary => true}} do
        run_rake("db:drop")
      end

      desc "Load seed data"
      task :seed, {:roles => :db, :only => {:primary => true}} do
        run_rake("db:seed")
      end

      task :init, {:roles => :db, :only => {:primary => true}} do
        tasks = %w(deploy:update_code
                   deploy:create_symlink
                   db:symlink
                   deploy:db:drop
                   deploy:db:create
                   deploy:migrate
                   deploy:db:seed)


        if ENV["FORCE_DEPLOY_DB_INIT"] == nil
          agree = Capistrano::CLI.ui.agree("deploy:db:init will DROP your database. Are you sure? (Yes, No)") do |q|
            q.default = 'No'
          end
        end

        transaction do
          tasks.each do |name|
            task = top.find_task(name)
            invoke_task_directly_without_callbacks(task)
          end
        end
      end
    end
  end
end
