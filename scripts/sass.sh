#!/usr/bin/env bash

echo "Installing SASS 3.4.10"
echo "Ensuring Ruby (dependency) is installed and up to date"
yum install -y ruby ruby-devel rubygems
echo "Ruby check complete. Version: `ruby --version`"


echo "#!/usr/bin/env bash" > /etc/profile.d/local-bin.sh
echo "pathmunge /usr/local/bin after" >> /etc/profile.d/local-bin.sh

gem install -N sass -v 3.4.10
echo "Installed SASS version: `/usr/local/bin/sass -v`"

echo "Installing Compass"
gem install -N compass -v 1.0.3
# needed to compile core sass
gem install -N compass-colors
echo "Compass installed `/usr/local/bin/compass -v`"
