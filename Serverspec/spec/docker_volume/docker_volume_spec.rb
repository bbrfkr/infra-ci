require 'docker_volume/spec_helper.rb'

describe ("docker_volume") do
  property['docker_volume']['volumes'].each do |volume|
    tls = property['docker_volume']['tls']['enable'] ? "DOCKER_TLS_VERIFY=1" : ""
    describe command("DOCKER_HOST=#{property['docker_volume']['docker_host']} #{tls} docker volume inspect #{volume['name']}") do
      its(:exit_status) { should eq 0 }
    end
  end
end
