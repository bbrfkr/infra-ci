#!/bin/sh -xe
export PATH=${PATH}:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:

### Vagrant(pre)
cd Vagrant/openstack_ntp_01
vagrant up
cd ../openstack_ntp_02
vagrant up

### Ansible(pre)
cd ../../Ansible
ROLES_DIR=`pwd`/roles
sed -i -e "s|roles_path\s*=\s*.\+|roles_path = ${ROLES_DIR}|g" ~/.ansible-art.cfg

ansible-art apply vagrant_root inventories/vagrant_root -a "-s"
ansible-art apply vagrant_root inventories/vagrant_root -a "-s --extra-vars=\"ansible_port=2223\""
ansible-art apply openstack_ntp inventories/openstack_ntp -p host_vars_dir/openstack_ntp_01
ansible-art apply openstack_ntp inventories/openstack_ntp -p host_vars_dir/openstack_ntp_02 -a "--extra-vars=\"ansible_port=2223\""

### Serverspec
cd ../Serverspec
cp properties/openstack_ntp_01.yml properties/openstack_ntp.yml
cp inventories/openstack_ntp_01.yml inventories/openstack_ntp.yml
rake -f Rakefiles/openstack_ntp spec
cp properties/openstack_ntp_02.yml properties/openstack_ntp.yml
cp inventories/openstack_ntp_02.yml inventories/openstack_ntp.yml
rake -f Rakefiles/openstack_ntp spec
RC=$?

### Vagrant(post)
cd ../Vagrant/openstack_ntp_01
vagrant destroy -f
cd ../openstack_ntp_02
vagrant destroy -f

exit $RC

