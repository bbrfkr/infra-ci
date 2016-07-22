require 'serverspec'
require 'net/ssh'
require 'yaml'

set :backend, :ssh

properties = YAML.load_file('properties/docker_container.yml')
host = ENV['CONN_HOST']
set_property properties[host]

set :sudo_password, ENV['CONN_PASS']

options = Net::SSH::Config.for(host)

options[:user] = ENV['CONN_USER']
options[:password] = ENV['CONN_PASS']
options[:port] = ENV['SSH_PORT']

set :host,        options[:host_name] || host
set :ssh_options, options
set :request_pty, true

# Disable sudo
set :disable_sudo, true


# Set environment variables
# set :env, :LANG => 'C', :LC_MESSAGES => 'C' 

# Set PATH
# set :path, '/sbin:/usr/local/sbin:$PATH'
