require 'openstack_packages/spec_helper'

describe ('openstack_packages') do
  describe ('check each package is installed') do
    describe package('centos-release-openstack-mitaka') do
      it { should be_installed }
    end

    describe package('python-openstackclient') do
      it { should be_installed }
    end

    describe package('openstack-selinux') do
      it { should be_installed }
    end
  end
end

