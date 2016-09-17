require 'openstack_ntp/spec_helper'

describe ("openstack_ntp") do
  hostname = Specinfra::backend.run_command("uname -n")[:stdout].chomp()
  controller = property['openstack_ntp']['controller']

  p hostname
  p controller

  describe ("check service is enabled") do
    describe service("chronyd") do
      it { should be_enabled }
      it { should be_running }
    end
  end

  describe ("check specifying time server to sync") do
    if hostname == controller
      property['openstack_ntp']['controller_ntp_entry'].each do |entry|
        describe file("/etc/chrony.conf") do
          its(:content) { should match /^server #{entry} iburst/ }
        end
      end
    else
      describe file ("/etc/chrony.conf") do
        its(:content) { should match /^server #{controller} iburst/ }
      end
    end
  end 

  describe ("check specifying allowed network to syncronize with controller") do
    if hostname == controller
      property['openstack_ntp']['controller_allow_network'].each do |network|
        describe file("/etc/chrony.conf") do
          its(:content) { should match /^allow #{network}/ }
        end
      end
    end
  end

  # functional test
  if property['openstack_ntp']['func_test']
    describe ("check whether target is syncronized with time server") do
      if hostname == controller
        describe command("chronyc sources | grep \"^\^\*\"") do
          its(:stdout) { should match /^\^\*/ }
        end
      else
        describe command("chronyc sources | grep #{controller}" ) do
          its(:stdout) { should match /^\^\*/ }
        end
      end
    end
  end
end
