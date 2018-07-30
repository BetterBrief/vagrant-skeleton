#!/usr/bin/env bash

echo "Installing LESS"

/vagrant/scripts/node.sh

npm install -g --bin-links less

echo "Less installed `less -v`"
