#!/bin/bash

echo "Installing SASS 3.2.19"
echo "Ensuring Ruby (dependency) is installed and up to date"
yum install -y ruby rubygems
echo "Ruby check complete. Version: `ruby --version`"
gem install sass -v 3.2.19
echo "Installed SASS version: `sass -v`"

echo "Installing Compass"
gem install compass -v 0.12.2
echo "Compass installed `compass -v`"
