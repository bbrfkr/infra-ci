require 'openstack_memcached/spec_helper'

describe ('openstack_memcached') do
  describe ('check package is installed') do
    describe package('memcached') do
      it { should be_installed }
    end
    describe package('python-memcached') do
      it { should be_installed }
    end
  end

  describe ('check service is enabled') do
    describe service('memcached') do
      it { should be_running }
      it { should be_enabled }
    end
  end
end
