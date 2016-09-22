require 'openstack_glance/spec_helper'

describe ("openstack_glance") do
  describe ('check database exists and database permissions are set') do
    describe command("mysql -uroot -p#{property['openstack_glance']['mariadb_pass']} -e \"show databases;\" | grep glance") do
      its(:exit_status) { should eq 0 }
    end
    describe command("mysql -uroot -p#{property['openstack_glance']['mariadb_pass']} -e \"show grants for \'glance\'@\'localhost\';\"") do
      its(:stdout) { should match /ALL PRIVILEGES ON `glance`\.\* TO 'glance'@'localhost'/}
    end
    describe command("mysql -uroot -p#{property['openstack_glance']['mariadb_pass']} -e \"show grants for \'glance\'@\'%\';\"") do
      its(:stdout) { should match /ALL PRIVILEGES ON `glance`\.\* TO 'glance'@'%'/}
    end
  end
end
