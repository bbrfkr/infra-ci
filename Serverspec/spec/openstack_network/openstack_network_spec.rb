require 'openstack_network/spec_helper.rb'

describe ("openstack_network") do
  describe ("check firewalld is disabled") do
    describe service('firewalld') do
      it { should_not be_enabled }
      it { should_not be_running }
    end
  end

  describe ("check hostname") do
    describe command("uname -n") do
      its(:stdout) { should eq "#{property['openstack_network']['hostname']}\n" }
    end
  end

  describe ("check hosts entries") do
    property['openstack_network']['hosts_entries'].each do |hosts_entry|
      describe host(hosts_entry['name']) do
        its(:ipv4_address) { should eq "#{hosts_entry['ip']}" }
      end
    end
  end

  describe ("check dns servers") do
    property['openstack_network']['dns_servers'].each do |dns_server|
      describe file("/etc/resolv.conf") do
        its(:content) { should match "nameserver\s+#{dns_server['server']}\s*$" }
      end
    end
  end

  describe ("check internet access") do
    describe host('www.yahoo.co.jp') do
      it { should be_reachable }
    end
  end
end
