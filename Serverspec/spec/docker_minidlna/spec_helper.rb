require 'serverspec'
require 'net/ssh'
require 'docker'

set :backend, :docker
set :docker_url, ENV["DOCKER_HOST"]
set :docker_container, ENV["DOCKER_CONTAINER"]

if ENV["DOCKER_CERT_PATH"] != nil
  Docker.options = {
      client_cert: File.join(ENV["DOCKER_CERT_PATH"], 'cert.pem'),
      client_key: File.join(ENV["DOCKER_CERT_PATH"], 'key.pem'),
      ssl_ca_file: File.join(ENV["DOCKER_CERT_PATH"], 'ca.pem'),
      scheme: 'https'
  }
end

