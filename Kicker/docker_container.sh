#!/bin/sh
export PATH=${PATH}:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:

### Ansible(pre)
cd Ansible
ansible-art -V
ROLES_DIR=`pwd`/roles
sed -i -e "s|roles_path\s*=\s*.\+|roles_path = ${ROLES_DIR}|g" ~/.ansible-art.cfg
ansible-art apply docker_container inventories/hosts_docker_container -p host_vars_dir/host_vars_docker_container_create -a "-s"

### Serverspec
cd ../Serverspec
rake -f Rakefiles/docker_container spec
RC=$?

### Ansible(post)
cd ../Ansible
ansible-art apply docker_container inventories/hosts_docker_container -p host_vars_dir/host_vars_docker_container_delete -a "-s"

exit $RC
