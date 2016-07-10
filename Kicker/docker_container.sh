#!/bin/sh

cd ../Ansible
ansible-art -V
ROLES_DIR=`pwd`/roles
sed -i -e "s|roles_path\s*=\s*.\+|roles_path = ${ROLES_DIR}|g" ~/.ansible-art.cfg
ansible-art apply docker_container inventories/hosts_docker_container -p host_vars_dir/host_vars_docker_container_create -a "-s"

cd ../Serverspec
rake -f Rakefiles/docker_container spec

cd ../Ansible
ansible-art apply docker_container inventories/hosts_docker_container -p host_vars_dir/host_vars_docker_container_delete -a "-s"
