#!/usr/bin/env bash
#Install the sspak tool
echo "Installing SSPak"

curl -sS https://silverstripe.github.io/sspak/install | php -- /usr/bin

echo "SSpak installed"
