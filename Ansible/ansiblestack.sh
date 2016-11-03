#!/bin/sh
date
ansible-art apply openstack_network inventories/openstack_network -p host_vars_dir/ansiblestack
ansible-art apply openstack_ntp inventories/openstack_ntp -p host_vars_dir/ansiblestack
ansible-art apply openstack_packages inventories/openstack_packages -p host_vars_dir/ansiblestack
ansible-art apply openstack_mariadb inventories/openstack_mariadb -p host_vars_dir/ansiblestack
ansible-art apply openstack_rabbitmq inventories/openstack_rabbitmq -p host_vars_dir/ansiblestack
ansible-art apply openstack_memcached inventories/openstack_memcached -p host_vars_dir/ansiblestack
ansible-art apply openstack_keystone_install inventories/openstack_keystone_install -p host_vars_dir/ansiblestack
ansible-art apply openstack_keystone_setup inventories/openstack_keystone_setup -p host_vars_dir/ansiblestack
ansible-art apply openstack_glance inventories/openstack_glance -p host_vars_dir/ansiblestack
ansible-art apply openstack_nova_controller inventories/openstack_nova_controller -p host_vars_dir/ansiblestack
ansible-art apply openstack_nova_compute inventories/openstack_nova_compute -p host_vars_dir/ansiblestack
ansible-art apply openstack_neutron_controller inventories/openstack_neutron_controller -p host_vars_dir/ansiblestack
ansible-art apply openstack_neutron_compute inventories/openstack_neutron_compute -p host_vars_dir/ansiblestack
ansible-art apply openstack_horizon inventories/openstack_horizon -p host_vars_dir/ansiblestack
ansible-art apply openstack_initial_setup inventories/openstack_initial_setup -p host_vars_dir/ansiblestack
date

