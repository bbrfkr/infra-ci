#!/bin/sh
export PATH=${PATH}:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:
export DOCKER_HOST=tcp://localhost:2375

### create container
docker run -itd --name test -p 137:137/udp -p 138:138/udp -p 139:139/tcp -p 445:445/tcp centos:7 /bin/bash

### Ansible
cd Ansible
ROLES_DIR=`pwd`/roles
GATHERING=explicit
sed -i -e "s|roles_path\s*=\s*.\+|roles_path = ${ROLES_DIR}|g" ~/.ansible-art.cfg
sed -i -e "s|gathering\s*=\s*.\+|gathering = ${GATHERING}|g" ~/.ansible-art.cfg
ansible-art apply docker_samba inventories/docker_samba

### Serverspec
cd ../Serverspec
rake -f Rakefiles/docker_samba spec
RC=$?

### delete container
docker rm -f test

exit $RC
