# config valid for current version and patch releases of Capistrano
lock "~> 3.11.2"
set :application, "study_cap"

set :linked_dirs, %w(log)

set :deploy_to, "/home/ec2-user/test-deploy"

# 指定のディレクトリのシンボルを作成
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", '.bundle'

namespace :deploy do
  desc 'restart nginx'
  task :nginx_restart do
    on roles(:app) do
      execute "sudo service nginx stop"
      execute "sudo service nginx start"
    end
  end
  after  :finished, :nginx_restart
end