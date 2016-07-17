require 'docker/spec_helper.rb'

describe ("docker") do
  describe ("check service is enabled and started") do
    describe service("docker") do
      it { should be_running }
      it { should be_enabled }
    end
  end

  describe ("check listen protocol, address and port") do
    property['docker']['listen'].each do |listen|
      port = listen['port'] != nil ? ":" + listen['port'].to_s : ""
      describe command("grep -e \"^OPTIONS\" /etc/sysconfig/docker | grep -e \"-H #{listen['protocol']}://#{listen['address']}#{port}\"") do
        its(:exit_status) { should eq 0 }
      end
    end 
  end
end
