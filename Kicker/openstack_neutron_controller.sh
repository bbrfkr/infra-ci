#!/bin/sh
export PATH=${PATH}:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:

### Vagrant(pre)
cd Vagrant/openstack_neutron_controller
vagrant up

### Ansible(pre)
cd ../../Ansible
ROLES_DIR=`pwd`/roles
sed -i -e "s|roles_path\s*=\s*.\+|roles_path = ${ROLES_DIR}|g" ~/.ansible-art.cfg
ansible-art apply vagrant_root inventories/vagrant_root -a "-s"
ansible-art apply openstack_packages inventories/openstack_packages
ansible-art apply openstack_mariadb inventories/openstack_mariadb
ansible-art apply ansible_keyfiles inventories/ansible_keyfiles
ansible-art apply openstack_keystone_install inventories/openstack_keystone_install -p host_vars_dir/openstack_keystone_install_01
ansible-art apply openstack_keystone_setup inventories/openstack_keystone_setup -p host_vars_dir/openstack_keystone_setup_01
ansible-art apply openstack_compute_controller inventories/openstack_compute_controller -p host_vars_dir/openstack_compute_controller_01
ansible-art apply openstack_neutron_controller inventories/openstack_neutron_controller -p host_vars_dir/openstack_neutron_controller_01

### Serverspec
cd ../Serverspec
rake -f Rakefiles/openstack_neutron_controller spec
RC=$?

exit 0 


### Vagrant(post)
cd ../Vagrant/openstack_neutron_controller
vagrant destroy -f

exit $RC
