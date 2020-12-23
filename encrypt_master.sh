#!/bin/bash -e

PROJECT_ROOT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# tmp
TMP_PATH=`mktemp -d`
trap "{ rm -rf ${TMP_PATH}; }" EXIT

# rm old pack file
rm -rf ${PROJECT_ROOT_PATH}/master.tar.gz.gpg.sig

# create gpg folder
mkdir -p ${TMP_PATH}/gpg
chmod 700 ${TMP_PATH}/gpg

# import private key
gpg \
  --homedir ${TMP_PATH}/gpg \
  --batch \
  --import ${PROJECT_ROOT_PATH}/master/private-key.asc

# tar | encrypt | sign
tar czf - master | \
gpg \
  --symmetric \
  --cipher-algo AES256 \
  --pinentry-mode loopback \
  --passphrase-file ${PROJECT_ROOT_PATH}/master/MASTER_SECRET | \
gpg \
  --homedir ${TMP_PATH}/gpg \
  --batch \
  --pinentry-mode loopback \
  --passphrase-file ${PROJECT_ROOT_PATH}/master/MASTER_SECRET \
  --output ${PROJECT_ROOT_PATH}/master.tar.gz.gpg.sig --sign
