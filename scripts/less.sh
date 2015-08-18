#!/usr/bin/env bash

echo "Installing LESS"

/vagrant/scripts/node.sh

npm install -g less

echo "Less installed `less -v`"
