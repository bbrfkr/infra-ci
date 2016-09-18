require 'openstack_mariadb/spec_helper'

describe ("openstack_mariadb") do
  describe ("check bind address") do
    describe file('/etc/my.cnf.d/openstack.cnf') do
      it { should contain("bind-address = #{property['openstack_mariadb']['bind_address']}").after(/^\[mysqld\]/) }
    end
  end

  describe ("check mariadb root password") do
    describe command("mysql -uroot -p#{property['openstack_mariadb']['mariadb_pass']}  -e \"show databases;\"") do
      its(:exit_status) { should eq 0 }
    end
  end

  describe ("check packages are installed") do
    describe package('mariadb') do
      it { should be_installed }
    end
    describe package('mariadb-server') do
      it { should be_installed }
    end
    describe package('python2-PyMySQL') do
      it { should be_installed }
    end
  end

  describe ("check service is enabled") do
    describe service('mariadb') do
      it { should be_running }
      it { should be_enabled }
    end
  end
end

