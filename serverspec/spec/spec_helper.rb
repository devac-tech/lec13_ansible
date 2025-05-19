require 'serverspec'

set :backend, :ssh
host = ENV['TARGET_HOST'] || 'target'

options = Net::SSH::Config.for(host)
options[:user] = 'ec2-user'
options[:keys] = ['~/.ssh/id_rsa']  # CircleCIに登録した鍵パス
set :host, host
set :ssh_options, options
set :request_pty, true
