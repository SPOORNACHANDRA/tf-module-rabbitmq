#!/bin/bash

yum install ansible -y &>>/opt/userdata.log
ansible-playbook -i localhost, -u https://github.com/SPOORNACHANDRA/ansible-roboshop-v1.git main.yml -e component=rabbitmq &>>/opt/userdata.log