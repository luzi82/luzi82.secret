#!/bin/bash
set -e

if [ -f secret/SECRET ]; then
  SECRET=`cat secret/SECRET`
else
  read -sp "SECRET: " SECRET
  echo
fi

rm -rf secret

gpg --quiet --batch --yes --decrypt --passphrase="${SECRET}" secret.tar.gz.gpg | \
tar xzf -
