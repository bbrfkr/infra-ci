#!/bin/sh
export PATH=${PATH}:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:

### Vagrant(pre)
cd Vagrant/openstack_compute_compute_01
vagrant up
cd ../openstack_compute_compute_02
vagrant up

### Ansible(pre)
cd ../../Ansible
ROLES_DIR=`pwd`/roles
sed -i -e "s|roles_path\s*=\s*.\+|roles_path = ${ROLES_DIR}|g" ~/.ansible-art.cfg
ansible-art apply vagrant_root inventories/vagrant_root -a "-s"
ansible-art apply vagrant_root inventories/vagrant_root -a "-s --extra-vars=\"ansible_port=2223\"" 
ansible-art apply openstack_network inventories/openstack_network -p host_vars_dir/openstack_compute_compute_01
ansible-art apply openstack_network inventories/openstack_network -p host_vars_dir/openstack_compute_compute_02 -a "--extra-vars=\"ansible_port=2223\""
ansible-art apply openstack_ntp inventories/openstack_ntp -p host_vars_dir/openstack_compute_compute_01
ansible-art apply openstack_ntp inventories/openstack_ntp -p host_vars_dir/openstack_compute_compute_02 -a "--extra-vars=\"ansible_port=2223\""
ansible-art apply openstack_packages inventories/openstack_packages -p host_vars_dir/openstack_compute_compute_01
ansible-art apply openstack_packages inventories/openstack_packages -p host_vars_dir/openstack_compute_compute_02 -a "--extra-vars=\"ansible_port=2223\""
ansible-art apply openstack_mariadb inventories/openstack_mariadb -p host_vars_dir/openstack_compute_compute_01
ansible-art apply openstack_rabbitmq inventories/openstack_rabbitmq -p host_vars_dir/openstack_compute_compute_01
ansible-art apply openstack_memcached inventories/openstack_memcached -p host_vars_dir/openstack_compute_compute_01
ansible-art apply ansible_keyfiles inventories/ansible_keyfiles -p host_vars_dir/openstack_compute_compute_01
ansible-art apply ansible_keyfiles inventories/ansible_keyfiles -p host_vars_dir/openstack_compute_compute_02 -a "--extra-vars=\"ansible_port=2223\""
ansible-art apply openstack_keystone_install inventories/openstack_keystone_install -p host_vars_dir/openstack_compute_compute_01
ansible-art apply openstack_keystone_setup inventories/openstack_keystone_setup -p host_vars_dir/openstack_compute_compute_01
ansible-art apply openstack_glance inventories/openstack_glance -p host_vars_dir/openstack_compute_compute_01
ansible-art apply openstack_compute_controller inventories/openstack_compute_controller -p host_vars_dir/openstack_compute_compute_01
ansible-art apply openstack_compute_compute inventories/openstack_compute_compute -p host_vars_dir/openstack_compute_compute_02 -a "--extra-vars=\"ansible_port=2223\""

exit 0

### Serverspec
cd ../Serverspec
rake -f Rakefiles/openstack_compute_compute spec
RC=$?

### Vagrant(post)
cd ../Vagrant/openstack_compute_compute
vagrant destroy -f

exit $RC
