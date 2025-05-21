require 'serverspec'
require 'net/ssh'

set :backend, :ssh
set :disable_sudo, true

# 環境変数から読み取る
host = ENV['TARGET_HOST']
raise 'TARGET_HOST is not set' if host.nil? || host.strip.empty?
puts "[DEBUG] ENV['TARGET_HOST'] = #{ENV['TARGET_HOST']}"
puts "[DEBUG] set :host = #{host}"

# 明示的にSSHオプションを定義
set :host, host
set :ssh_options, {
  user: 'ec2-user',
  keys: ['~/.ssh/id_rsa_f4f2ec1be69af5cc96aa8044c2177d52'],
  auth_methods: ['publickey'],
  verify_host_key: :never
}
