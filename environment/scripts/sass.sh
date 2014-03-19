#!/bin/bash

echo "Installing SASS"
echo "Ensuring Ruby (dependency) is installed and up to date"
yum install -y ruby ruby-devel rubygems
echo "Ruby check complete. Version: `ruby --version`"
gem install rb-inotify
gem install sass
echo "Installed SASS version: `sass -v`"
