require 'serverspec'
require 'net/ssh'

# テストの実行先は「リモート（SSH）」
set :backend, :ssh

# sudo パスワードの取得処理
if ENV['ASK_SUDO_PASSWORD']
  begin
    require 'highline/import'
  rescue LoadError
    fail "highline is not available. Try installing it."
  end
  set :sudo_password, ask("Enter sudo password: ") { |q| q.echo = false }
else
  set :sudo_password, ENV['SUDO_PASSWORD']
end

# ホストと SSH 接続オプション
host = ENV['TARGET_HOST']
raise 'TARGET_HOST is not set' if host.nil? || host.strip.empty?
# puts "TARGET_HOST => #{host}"

# ~/.ssh/config に設定があればそれを自動的に読み込む
options = Net::SSH::Config.for(host)

# config に設定がない場合に備え、直接設定を補完
# options[:host_name] ||= host
# options[:user]      ||= 'ec2-user'
options[:keys]      ||= ['~/.ssh/id_rsa_aws_from_m1_win.pem']
# options[:auth_methods] ||= ['publickey']

# ユーザー指定がなければ、現在ログイン中のユーザー名を使う
options[:user] ||= Etc.getlogin

# 実際に接続するホスト名（IP）と、SSHのオプションを Serverspec に渡す
set :host,        options[:host_name] || host
set :ssh_options, options