#!/usr/bin/env bash
# sign built packages for release

set -o errexit
set -o nounset
set -o pipefail

# gpg is weird
export GPG_TTY=$(tty)

GPGKEY="038CCBF3DAD6946AF5ECC4F9B00B5AAA0E096100"

if [ ! -d ./staging ]; then
    echo "No staging folder, exiting"
    exit 1
fi

cd ./staging
if stat -t *.deb >/dev/null 2>&1
then
    dpkg-sig --verbose -k "$GPGKEY" --sign builder *.deb
else
    echo "No packages matching *.deb found in ./staging"
fi
