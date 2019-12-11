set :rails_env, 'production'

# サーバー、ユーザー、ロールの指定
server "13.230.203.60", user: "ec2-user", roles: %w{app db web}

set :repo_url, "git@github.com:tabachain/study_cap.git"

# デプロイするブランチ指定
set :branch, 'master'

set :ssh_options, keys: '~/.ssh/keys/tabachain-private-work.pem'