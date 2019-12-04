set :rails_env, 'production'

# サーバー、ユーザー、ロールの指定
server "ec2-13-230-164-25.ap-northeast-1.compute.amazonaws.com", user: "ec2-user", roles: %w{app db web}

# デプロイ先のリポジトリ指定(/home/ec2-user/test-deploy.git)
set :repo_url, "/home/ec2-user/test-deploy.git"

# デプロイするブランチ指定
set :branch, 'how_to_capistrano'

# 環境変数の指定
set :default_env, {
    test: "test_data",
    RAILS_MASTER_KEY: "7adf04337b905675ec71500f7e6f3e3d"
}

# SSHの設定
set :ssh_options, {
    keys: %w(env-test.pem),
    forward_agent: false
}