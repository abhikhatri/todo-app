# Settings for staging server
server '169.55.65.167', :app, :web, :db, :primary => true
set :rails_env, 'production'

set :use_sudo, false
set :deploy_via, :remote_cache
set :user, 'abhikhatri'
set :rvm_ruby_version, 'ruby-2.1.0'
set :deploy_to, "/home/#{user}/#{application}"
set :branch, 'master'