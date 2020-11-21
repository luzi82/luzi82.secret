#!/bin/bash
set -e

TMP_PATH=`mktemp -d`
trap "{ rm -rf ${TMP_PATH}; }" EXIT

# rm old pack file
rm -rf secret.tar.gz.gpg.sig

# create gpg folder
mkdir -p ${TMP_PATH}/gpg
chmod 700 ${TMP_PATH}/gpg

# import private key
gpg --homedir ${TMP_PATH}/gpg --batch --import master/private-key.asc

# tar | encrypt | sign
tar czf - secret | \
gpg --symmetric --cipher-algo AES256 --pinentry-mode loopback --passphrase-file master/SECRET | \
gpg --homedir ${TMP_PATH}/gpg --batch --pinentry-mode loopback --passphrase-file master/MASTER_SECRET --output secret.tar.gz.gpg.sig --sign
