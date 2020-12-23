#!/bin/bash -e

if [ -f master/MASTER_SECRET ]; then
  MASTER_SECRET=`cat master/MASTER_SECRET`
else
  read -sp "MASTER_SECRET: " MASTER_SECRET
  echo
fi

# rm exising master
rm -rf master

# verify | decrypt | untar
gpg --no-default-keyring --keyring ${PWD}/public-key.gpg --decrypt master.tar.gz.gpg.sig | \
gpg --quiet --batch --yes --decrypt --passphrase="${MASTER_SECRET}" | \
tar xzf -
