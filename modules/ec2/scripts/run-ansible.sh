#!/bin/sh
set -x
export ansible_home=/tmp/scripts/ansible
cd ${ansible_home} || exit

find . -type f -print0 | xargs -0 dos2unix || exit


#Playbooks not generated by silent
sudo ansible-playbook -i hosts moni-jboss72.yml