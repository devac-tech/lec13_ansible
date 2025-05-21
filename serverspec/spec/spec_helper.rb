require 'serverspec'
require 'net/ssh'

set :backend, :ssh
set :disable_sudo, true

host = ENV['TARGET_HOST']
raise 'TARGET_HOST is not set' if host.nil? || host.strip.empty?

options = Net::SSH::Config.for('target') # ← SSH config で定義した "target" を使う
set :host,        options[:host_name] || host
set :ssh_options, options
