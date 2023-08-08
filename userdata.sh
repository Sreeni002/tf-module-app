#!/bin/bash

labauto ansible
ansible-pull -i localhost, -U https://github.com/Sreeni002/iRobo-shell.git roboshop.yml -e role_name = ${name} -e env=${env} &>>/opt/ansible.log
