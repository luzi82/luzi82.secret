#!/bin/bash
set -e

if [ -f master/SECRET ]; then
  SECRET=`cat master/SECRET`
else
  read -sp "SECRET: " SECRET
  echo
fi

# rm exising secret
rm -rf secret

# verify | decrypt | untar
gpg --no-default-keyring --keyring ${PWD}/public-key.gpg --decrypt secret.tar.gz.gpg.sig | \
gpg --quiet --batch --yes --decrypt --passphrase="${SECRET}" | \
tar xzf -
