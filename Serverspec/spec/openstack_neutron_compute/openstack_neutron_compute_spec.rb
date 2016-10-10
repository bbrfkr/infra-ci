require "openstack_neutron_compute/spec_helper"

describe ("openstack_neutron_compute") do
  describe ("check packages are installed") do
    packages = ["openstack-neutron-linuxbridge", "ebtables", "ipset"]

    packages.each do |p|
      describe package(p) do
        it { should be_installed }
      end
    end
  end

  describe ("check services are enabled") do
    services = ["neutron-linuxbridge-agent"]

    services.each do |s|
      describe service(s) do
        it { should be_running }
        it { should be_enabled }
      end
    end
  end
end
