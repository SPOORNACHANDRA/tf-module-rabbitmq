#!/bin/bash

yum install ansible python3.11.-pip.norch -y &>>/opt/userdata.log
ansible-pull -i localhost, -U https://github.com/SPOORNACHANDRA/ansible-roboshop-v1.git main.yml -e component=rabbitmq &>>/opt/userdata.log