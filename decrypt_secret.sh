#!/bin/bash -e

PROJECT_ROOT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# secret
cd ${PROJECT_ROOT_PATH}
if [ -f master/SECRET ]; then
  SECRET=`cat ${PROJECT_ROOT_PATH}/master/SECRET`
else
  read -sp "SECRET: " SECRET
  echo
fi

# rm exising secret
cd ${PROJECT_ROOT_PATH}
rm -rf ${PROJECT_ROOT_PATH}/secret

# verify ; decrypt | untar
cd ${PROJECT_ROOT_PATH}
gpg \
  --no-default-keyring \
  --keyring ${PROJECT_ROOT_PATH}/public-key.gpg \
  --verify ${PROJECT_ROOT_PATH}/secret.tar.gz.gpg.sig
gpg \
  --no-default-keyring \
  --keyring ${PROJECT_ROOT_PATH}/public-key.gpg \
  --decrypt ${PROJECT_ROOT_PATH}/secret.tar.gz.gpg.sig | \
gpg --quiet --batch --yes --decrypt --passphrase="${SECRET}" | \
tar xzf -
