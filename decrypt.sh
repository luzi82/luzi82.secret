#!/bin/bash
set -e

if [ -f secret/SECRET ]; then
  SECRET=`cat secret/SECRET`
else
  read -sp "SECRET: " SECRET
  echo
fi

rm -rf tmp secret
mkdir -p tmp

gpg --quiet --batch --yes --decrypt --passphrase="${SECRET}" --output tmp/secret.tar.gz secret.tar.gz.gpg
tar -xzf tmp/secret.tar.gz

rm -rf tmp
