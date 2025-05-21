require 'serverspec'
require 'net/ssh'
require 'etc'

# テスト対象はリモート（SSH接続）
set :backend, :ssh

# sudoを無効化（NOPASSWD 環境のため）
set :disable_sudo, true

# 必須の環境変数が設定されているかを検証
host = ENV['TARGET_HOST']
raise 'TARGET_HOST is not set' if host.nil? || host.strip.empty?

# ~/.ssh/config の内容を読み込み、必要な接続設定を取得
options = Net::SSH::Config.for(host)

# SSHユーザー未設定なら、現在のユーザーを使用
options[:user] ||= Etc.getlogin

# Serverspec に接続情報を渡す
set :host,        options[:host_name] || host
set :ssh_options, options
