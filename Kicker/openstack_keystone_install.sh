#!/bin/sh
export PATH=${PATH}:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:

### Vagrant(pre)
cd Vagrant/openstack_keystone_install
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

### Serverspec
cd ../Serverspec
rake -f Rakefiles/openstack_keystone_install spec
RC=$?

### Vagrant(post)
cd ../Vagrant/openstack_keystone_install
vagrant destroy -f

exit $RC
