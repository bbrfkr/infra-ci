#!/bin/sh
export PATH=${PATH}:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:

### Vagrant(pre)
cd Vagrant/ansible_keyfiles
vagrant up

### Ansible(pre)
cd ../../Ansible
ROLES_DIR=`pwd`/roles
sed -i -e "s|roles_path\s*=\s*.\+|roles_path = ${ROLES_DIR}|g" ~/.ansible-art.cfg
ansible-art apply vagrant_root inventories/vagrant_root -a "-s"
ansible-art apply ansible_keyfiles inventories/ansible_keyfiles

### Serverspec
cd ../Serverspec
rake -f Rakefiles/ansible_keyfiles spec
RC=$?

### Vagrant(post)
cd ../Vagrant/ansible_keyfiles
vagrant destroy -f

exit $RC
