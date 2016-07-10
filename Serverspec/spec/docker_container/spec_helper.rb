require 'serverspec'
require 'net/ssh'
require 'docker'

set :backend, :docker
set :docker_url, ENV["DOCKER_HOST"]
set :docker_container, ENV["DOCKER_CONTAINER"]
