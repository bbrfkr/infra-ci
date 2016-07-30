#!/bin/sh
export PATH=${PATH}:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:
export DOCKER_HOST=tcp://localhost:2375

### create container
docker run -itd --name test --net=host ubuntu:16.04 /bin/bash

### Ansible
cd Ansible
ROLES_DIR=`pwd`/roles
GATHERING=explicit
sed -i -e "s|roles_path\s*=\s*.\+|roles_path = ${ROLES_DIR}|g" ~/.ansible-art.cfg
sed -i -e "s|gathering\s*=\s*.\+|gathering = ${GATHERING}|g" ~/.ansible-art.cfg
ansible-art apply docker_minidlna inventories/docker_minidlna

### Serverspec
cd ../Serverspec
rake -f Rakefiles/docker_minidlna spec
RC=$?

### delete container
docker rm -f test

exit $RC
