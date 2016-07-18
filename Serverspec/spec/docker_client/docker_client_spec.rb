require 'docker_client/spec_helper.rb'

describe ("docker_client") do
  describe ("check service is enabled and started") do
    describe package("docker") do
      it { should be_installed }
    end
  end

  if property['docker_client']['tls']['enable']
    describe ("check ca cert, cert and key") do
      home_dir = Specinfra::backend.run_command("grep -e \"^#{property['docker_client']['install_user']}\" /etc/passwd | awk -F: '{ print $6 }'").stdout.chomp
      describe file("#{home_dir}/.docker/ca.pem") do
        it { should exist }
      end
      describe file("#{home_dir}/.docker/cert.pem") do
        it { should exist }
      end
      describe file("#{home_dir}/.docker/key.pem") do
        it { should exist }
      end
    end
  end
end
