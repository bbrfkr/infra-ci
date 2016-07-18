#!/bin/sh
export PATH=${PATH}:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:

### Vagrant(pre)
cd Vagrant/docker
vagrant up

### Ansible
cd ../../Ansible
ROLES_DIR=`pwd`/roles
sed -i -e "s|roles_path\s*=\s*.\+|roles_path = ${ROLES_DIR}|g" ~/.ansible-art.cfg
ansible-art apply vagrant_root inventories/vagrant_root -a "-s"
ansible-art apply docker inventories/docker

### Serverspec
cd ../Serverspec
rake -f Rakefiles/docker spec
RC=$?

### Vagrant(post)
cd ../Vagrant/docker
vagrant destroy -f

exit $RC
