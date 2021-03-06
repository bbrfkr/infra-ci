#!/bin/sh
export PATH=${PATH}:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:

### Vagrant(pre)
cd Vagrant/openstack_rabbitmq
vagrant up

### Ansible(pre)
cd ../../Ansible
ROLES_DIR=`pwd`/roles
sed -i -e "s|roles_path\s*=\s*.\+|roles_path = ${ROLES_DIR}|g" ~/.ansible-art.cfg
ansible-art apply vagrant_root inventories/vagrant_root -a "-s"
ansible-art apply openstack_packages inventories/openstack_packages
ansible-art apply openstack_rabbitmq inventories/openstack_rabbitmq

### Serverspec
cd ../Serverspec
rake -f Rakefiles/openstack_rabbitmq spec
RC=$?

### Vagrant(post)
cd ../Vagrant/openstack_rabbitmq
vagrant destroy -f

exit $RC
