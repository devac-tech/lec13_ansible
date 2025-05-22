require 'serverspec'
require 'net/ssh'

# SSHバックエンド
set :backend, :ssh

# sudo
# set :disable_sudo, false

# sudo パスワード設定（必要なら）
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

# 固定の "target" を使用（~/.ssh/config の Host名と一致）
host = ENV['TARGET_HOST'] || 'target'

# ~/.ssh/config を自動読み込み
options = Net::SSH::Config.for(host)

# ユーザーが設定されていなければ、現在のログインユーザーを使用
options[:user] ||= Etc.getlogin

# ホスト設定
set :host, options[:host_name] || host
set :ssh_options, options

# OS検出設定
RSpec.configure do |c|
  c.host = host
end