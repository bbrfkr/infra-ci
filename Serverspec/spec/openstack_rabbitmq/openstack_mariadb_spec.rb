require 'openstack_rabbitmq/spec_helper'

describe ("openstack_rabbitmq") do
  describe ('check package is installed') do
    describe package('rabbitmq-server') do
      it { should be_installed }
    end
  end

  describe ('check openstack user\'s  permissions') do
    describe command('rabbitmqctl list_permissions | grep openstack') do
      its(:stdout) { should match /\.\*\s*\.\*\s*\.\*/ }
    end
  end

  describe ('check service is enabled') do
    describe service('rabbitmq-server') do
     it { should be_running }
     it { should be_enabled }
    end
  end
end

