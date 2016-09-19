require 'openstack_keystone_setup/spec_helper'

describe ("openstack_keystone_setup") do
  describe ('check admin auth token is set') do
    describe command("openstack --os-auth-url http://#{property['openstack_keystone_setup']['controller']}:35357/v3 --os-project-domain-name #{property['openstack_keystone_setup']['domain']} --os-user-domain-name #{property['openstack_keystone_setup']['domain']} --os-project-name admin --os-username admin token issue --os-password #{property['openstack_keystone_setup']['admin_pass']}") do
      its(:exit_status) { should eq 0 }
    end
  end

  describe ('check demo auth token is set') do
    describe command(" openstack --os-auth-url http://#{property['openstack_keystone_setup']['controller']}:5000/v3 --os-project-domain-name #{property['openstack_keystone_setup']['domain']} --os-user-domain-name #{property['openstack_keystone_setup']['domain']} --os-project-name demo --os-username demo token issue --os-password #{property['openstack_keystone_setup']['demo_pass']}") do
      its(:exit_status) { should eq 0 }
    end
  end

  describe ('check openrc scripts are set') do
    describe file("#{property['openstack_keystone_setup']['script_dir']}/admin-openrc") do
      it { should exist }
    end
    describe file("#{property['openstack_keystone_setup']['script_dir']}/demo-openrc") do
      it { should exist }
    end
  end
end
