#!/bin/bash
MONGODB_REPO="/etc/yum.repos.d/mongodb.repo"

echo "Add the MongoDB Repo"
if [ -f ${MONGODB_REPO} ]; then
     echo "$MONGODB_REPO found"
else
cat << 'EOF' > ${MONGODB_REPO}
[mongodb]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/
gpgcheck=0
enabled=1
EOF
fi

echo "Installing MongoDB..."
yum install -y mongo-10gen mongo-10gen-server

echo "Installing init script of MongoDB..."
chkconfig mongod on

echo "Starting MongoDB..."
service mongod start
