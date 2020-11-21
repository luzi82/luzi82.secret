#!/bin/bash
set -e

TMP_PATH=`mktemp -d`
trap "{ rm -rf ${TMP_PATH}; }" EXIT

# rm old pack file
rm -rf secret.tar.gz.gpg.sig

# import private key
mkdir -p ${TMP_PATH}/gpg
gpg --homedir ${TMP_PATH}/gpg --batch --import secret/private-key.asc

# tar | encrypt | sign
tar czf - secret | \
gpg --symmetric --cipher-algo AES256 --pinentry-mode loopback --passphrase-file secret/SECRET | \
gpg --homedir ${TMP_PATH}/gpg --batch --pinentry-mode loopback --passphrase-file secret/SECRET --output secret.tar.gz.gpg.sig --sign
