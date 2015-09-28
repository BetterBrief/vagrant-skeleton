#!/usr/bin/env bash

echo "Installing HHVM"

echo "Installing dependencies"
/vagrant/scripts/epel.sh

wget https://copr.fedoraproject.org/coprs/no1youknowz/hhvm-repo/repo/epel-7/no1youknowz-hhvm-repo-epel-7.repo -O /etc/yum.repos.d/no1youknowz-hhvm-repo-epel-7.repo

sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/no1youknowz-hhvm-repo-epel-7.repo

yum install -y --enablerepo=no1youknowz-hhvm-repo --enablerepo=epel hhvm

echo "Installation complete"
