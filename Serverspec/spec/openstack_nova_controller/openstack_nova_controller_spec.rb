require "openstack_nova_controller/spec_helper"

describe ("openstack_nova_controller") do
  describe ("check packages are installed") do
    packages = ["openstack-nova-api", "openstack-nova-conductor", \
                "openstack-nova-console", "openstack-nova-novncproxy", \
                "openstack-nova-scheduler"]

    packages.each do |p|
      describe package(p) do
        it { should be_installed }
      end
    end
  end

  describe ("check services are enabled") do
    services = ["openstack-nova-api", "openstack-nova-consoleauth", \
                "openstack-nova-scheduler", "openstack-nova-conductor",
                "openstack-nova-novncproxy"]

    services.each do |s|
      describe service(s) do
        it { should be_running }
        it { should be_enabled }
      end
    end
  end
end
