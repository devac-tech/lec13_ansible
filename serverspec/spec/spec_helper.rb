require 'serverspec'
require 'net/ssh'

# SSHバックエンド
set :backend, :ssh

# sudo
set :disable_sudo, false

# 固定の "target" を使用（~/.ssh/config の Host名と一致）
host = 'target'

# ~/.ssh/config を自動読み込み
options = Net::SSH::Config.for(host)

# ホスト設定
set :host, options[:host_name] || host
set :ssh_options, options

# OS検出設定（省略可能）
RSpec.configure do |c|
  c.host = host
end
