#!/usr/bin/env bash
# copy and generate release file for new packages

# exit if a command fails
set -o errexit

# exit if required variables aren't set
set -o nounset

# gpg is weird
export GPG_TTY=$(tty)

# GPG key to use for signing
GPGKEY="038CCBF3DAD6946AF5ECC4F9B00B5AAA0E096100"
# path to repo
REPOPATH="/var/www/packages.galenguyer.com/debian"

if [ ! -d "$REPOPATH" ]; then
    echo "No repo folder, exiting"
    exit 1
fi
if [ ! -d "./staging" ]; then
    echo "No staging folder, exiting"
    exit 1
fi

cp ./staging/*deb "$REPOPATH" -v
cd "$REPOPATH"

# build Packages file
echo "building Packages file"
apt-ftparchive packages . > Packages
bzip2 -kf Packages

echo "building signed Release file"
# build signed Release file
apt-ftparchive release . > Release
gpg --yes -abs -u "$GPGKEY" -o Release.gpg Release
