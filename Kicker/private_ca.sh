#!/bin/sh
export PATH=${PATH}:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:

### Vagrant(pre)
cd Vagrant/private_ca
vagrant up

### Ansible
cd ../../Ansible
ROLES_DIR=`pwd`/roles
sed -i -e "s|roles_path\s*=\s*.\+|roles_path = ${ROLES_DIR}|g" ~/.ansible-art.cfg
ansible-art apply vagrant_root inventories/vagrant_root -a "-s"
ansible-art apply private_ca inventories/private_ca

### Serverspec
cd ../Serverspec
rake -f Rakefiles/private_ca spec
RC=$?

### Vagrant(post)
cd ../Vagrant/private_ca
vagrant destroy -f

exit $RC
