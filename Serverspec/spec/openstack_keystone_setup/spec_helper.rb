require 'serverspec'
require 'net/ssh'
require 'yaml'

set :backend, :ssh

properties = YAML.load_file('properties/openstack_keystone_setup.yml')
host = ENV['CONN_HOST']
set_property properties[host]

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


options = Net::SSH::Config.for(host)

options[:user] = ENV['CONN_USER']
options[:password] = ENV['CONN_PASS']
options[:port] = ENV['SSH_PORT']

set :host,        options[:host_name] || host
set :ssh_options, options

# Disable sudo
# set :disable_sudo, true


# Set environment variables
# set :env, :LANG => 'C', :LC_MESSAGES => 'C' 

# Set PATH
# set :path, '/sbin:/usr/local/sbin:$PATH'
