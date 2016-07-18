require 'docker_container/spec_helper.rb'

describe ("docker_container") do
  tls = property['docker_container']['tls']['enable'] ? "DOCKER_TLS_VERIFY=1" : ""
  property['docker_container']['containers'].each do |container|
    describe ("check container is running") do
      describe command("DOCKER_HOST=#{property['docker_container']['docker_host']} #{tls} docker inspect #{container['name']}") do
        its(:exit_status) { should eq 0 }
      end
    end
  end
end
