# config valid for current version and patch releases of Capistrano
lock "~> 3.11.2"
set :application, "study_cap"

set :linked_dirs, %w(log)

set :deploy_to, "/home/ec2-user/test-deploy"

set :log_level, :debug
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

  namespace :assets do
    desc 'Run the precompile task locally and rsync the assets'
    task :precompile do
      Rake.sh "npm install --prefix .local-yarn -g yarn@1.2"
      Rake.sh '.local-yarn/bin/yarn install'
      Rake.sh '.local-yarn/bin/yarn run build'
      raise 'ERROR: yarn install or yarn run build failed at deploy:assets:precompile !' unless $?.success?
      Rake.sh "RAILS_ENV=#{fetch(:rails_env)} bundle exec rake assets:precompile"
    end
  end
  after  :finished, :nginx_restart
end