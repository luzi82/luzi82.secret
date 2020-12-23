#!/bin/bash -e

PROJECT_ROOT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# secret
cd ${PROJECT_ROOT_PATH}
if [ -f master/MASTER_SECRET ]; then
  MASTER_SECRET=`cat ${PROJECT_ROOT_PATH}/master/MASTER_SECRET`
else
  read -sp "MASTER_SECRET: " MASTER_SECRET
  echo
fi

# rm exising master
cd ${PROJECT_ROOT_PATH}
rm -rf ${PROJECT_ROOT_PATH}/master

# verify ; decrypt | untar
cd ${PROJECT_ROOT_PATH}
gpg \
  --no-default-keyring \
  --keyring ${PROJECT_ROOT_PATH}/public-key.gpg \
  --verify ${PROJECT_ROOT_PATH}/master.tar.gz.gpg.sig
gpg \
  --no-default-keyring \
  --keyring ${PROJECT_ROOT_PATH}/public-key.gpg \
  --decrypt ${PROJECT_ROOT_PATH}/master.tar.gz.gpg.sig | \
gpg --quiet --batch --yes --decrypt --passphrase="${MASTER_SECRET}" | \
tar xzf -
