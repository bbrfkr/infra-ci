require "openstack_nova_compute/spec_helper"

describe ("openstack_nova_compute") do
  describe ("check packages are installed") do
    packages = ["openstack-nova-compute"]

    packages.each do |p|
      describe package(p) do
        it { should be_installed }
      end
    end
  end

  describe ("check services are enabled") do
    services = ["libvirtd", "openstack-nova-compute"]

    services.each do |s|
      describe service(s) do
        it { should be_running }
        it { should be_enabled }
      end
    end
  end

  if property['openstack_nova_compute']['virt_support']
    describe ("check virtualization support feature is enabled") do
      describe command("grep \"\\(vmx\\|svm\\)\" /proc/cpuinfo") do
        its(:exit_status) { should eq 0 }
      end
    end
  end
end

