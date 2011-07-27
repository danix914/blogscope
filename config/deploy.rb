set :application, "blogscope"
set :repository,  "git@github.com:danix914/blogscope.git"
set :deploy_to, "/pixnet/weblib/blogscope"
set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
ssh_options[:keys] = ["#{ENV['HOME']}/Download/det.pem"]

role :web, "ec2-50-17-177-123.compute-1.amazonaws.com"                          # Your HTTP server, Apache/etc
role :app, "ec2-50-17-177-123.compute-1.amazonaws.com"                          # This may be the same as your `Web` server
role :db,  "ec2-50-17-177-123.compute-1.amazonaws.com", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
# set :deploy_via, :remote_cache
set :deploy_env, "production"
set :rails_env, "production"
set :branch, 'master'
set :scm_verbose, true
# set :use_sudo, false

set :user, 'root'
set :group, 'root'

namespace :deploy do
  desc "restart"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
#     system("echo `whoami` 'is deploying pixlovely (Branch #{branch}) to #{deploy_servers} now' | nc ircbot.srv.pixnet 11963")
  end
end

desc "Create database.yml and asset packages for production"
after("deploy:update_code") do
  # link shared file
  db_config = "/pixnet/dbconfig/blogscope-db.yml"
  env_config = "/pixnet/dbconfig/blogscope-env.yml"
  run "cp #{db_config} #{release_path}/config/database.yml"
  run "cp #{env_config} #{release_path}/config/env.yml"
end