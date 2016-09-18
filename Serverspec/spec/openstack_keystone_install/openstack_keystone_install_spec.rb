require 'openstack_keystone_install/spec_helper'

describe ("openstack_keystone_install") do
  describe ('check keyfiles existence') do
    describe file('/var/ansible_keyfiles/openstack_keystone/db_sync') do
      it { should exist }
    end
    describe file('/var/ansible_keyfiles/openstack_keystone/fernet_setup') do
      it { should exist }
    end
  end

  describe ('check packages are installed') do
    describe package('openstack-keystone') do
      it { should be_installed }
    end
    describe package('httpd') do
      it { should be_installed }
    end
    describe package('mod_wsgi') do
      it { should be_installed }
    end
  end

  describe ('check service is enabled') do
    describe service('httpd') do
      it { should be_running }
      it { should be_enabled }
    end
  end

  describe ('check database are setup') do
    describe command("mysql -uroot -p#{property['openstack_keystone_install']['mariadb_pass']} -e \"show databases;\" | grep keystone") do
      its(:exit_status) { should eq 0 }
    end
    describe command("mysql -uroot -p#{property['openstack_keystone_install']['mariadb_pass']} -e \"show grants for \'keystone\'@\'localhost\';\"") do
      its(:stdout) { should match /ALL PRIVILEGES ON `keystone`\.\* TO 'keystone'@'localhost'/}
    end
    describe command("mysql -uroot -p#{property['openstack_keystone_install']['mariadb_pass']} -e \"show grants for \'keystone\'@\'%\';\"") do
      its(:stdout) { should match /ALL PRIVILEGES ON `keystone`\.\* TO 'keystone'@'%'/}
    end
  end
end
