set :application, "openlibrary"
set :repository, "git://github.com/TWChennai/openlibrary.git"
set :user, "root"

set :scm, :git
role :web, "10.10.4.50" # Your HTTP server, Apache/etc
role :app, "10.10.4.50" # This may be the same as your `Web` server
role :db, "10.10.4.50", :primary => true # This is where Rails migrations will run

default_run_options[:pty] = true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do
    run 'cd #{release_path} && passenger start -p80 -d'
  end
  task :stop do
    run 'cd #{release_path} && passenger stop -p80'
  end
  task :restart, :roles => :app do
    deploy.stop
    deploy.start
  end
end

namespace :bundler do
  desc "Install for production"
  task :install, :roles => :app do
    run "cd #{release_path} && bundle install --binstubs --without=development test"
  end
end

before 'deploy:update_code', 'deploy:stop'
after 'deploy:update_code', 'bundler:install'

