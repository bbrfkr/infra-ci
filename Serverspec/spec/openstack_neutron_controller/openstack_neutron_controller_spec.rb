require "openstack_neutron_controller/spec_helper"

describe ("openstack_neutron_controller") do
  describe ("check packages are installed") do
    packages = ["openstack-neutron", "openstack-neutron-ml2",
                "openstack-neutron-linuxbridge", "ebtables"]

    packages.each do |p|
      describe package(p) do
        it { should be_installed }
      end
    end
  end

  describe ("check services are enabled") do
    services = ["neutron-linuxbridge-agent", "neutron-dhcp-agent",
                "neutron-metadata-agent", "neutron-l3-agent"]

    services.each do |s|
      describe service(s) do
        it { should be_running }
        it { should be_enabled }
      end
    end
  end
end
