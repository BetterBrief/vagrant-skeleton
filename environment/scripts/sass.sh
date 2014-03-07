#!/bin/bash

echo "Installing SASS"
echo "Ensuring Ruby (dependency) is installed and up to date"
yum install -y ruby rubygems
echo "Ruby check complete. Version: `ruby --version`"
gem install sass
echo "Installed SASS version: `sass -v`"
