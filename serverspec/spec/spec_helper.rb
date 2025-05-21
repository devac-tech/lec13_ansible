require 'serverspec'

set :backend, :ssh

set :host, ENV['TARGET_HOST'] || '13.115.140.178'
set :ssh_options, {
  user: 'ec2-user',
  keys: ['~/.ssh/id_rsa_aws_from_m1_win.pem'],
  forward_agent: false,
  auth_methods: ['publickey']
}
set :sudo_password, ENV['SUDO_PASSWORD']
