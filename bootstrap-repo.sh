#!/bin/sh

curl -sSL https://gpg.galenguyer.com/ | sudo apt-key add -
echo "deb https://packages.galenguyer.com/debian ./" | sudo tee /etc/apt/sources.list.d/galenguyer.list
sudo apt-get update
