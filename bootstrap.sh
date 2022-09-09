#!/bin/bash

sudo -i

usermod -aG wheel vagrant
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd

su vagrant