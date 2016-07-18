require 'docker_tls/spec_helper.rb'

describe ("docker_tls") do
  describe ("check ca cert, cert and key") do
    describe file("#{property['docker_tls']['docker_cert_path']}/ca.pem") do
      it { should exist }
    end
    describe file("#{property['docker_tls']['docker_cert_path']}/cert.pem") do
      it { should exist }
    end
    describe file("#{property['docker_tls']['docker_cert_path']}/key.pem") do
      it { should exist }
    end
  end
end
