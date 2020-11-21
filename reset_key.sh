#!/bin/bash

KEY_ID=${1}

TMP_PATH=`mktemp -d`
trap "{ rm -rf ${TMP_PATH}; }" EXIT

# rm old key files
rm secret/private-key.asc
rm public-key.gpg
rm public-key.asc

# create gpg folder
mkdir -p ${TMP_PATH}/gpg
chmod 700 ${TMP_PATH}/gpg

# create gpg key pair
gpg --homedir ${TMP_PATH}/gpg --batch --gen-key ${PWD}/secret/gpg-gen-key

# export private key
gpg --homedir ${TMP_PATH}/gpg --batch --pinentry-mode loopback --passphrase-file secret/SECRET --armor --output secret/private-key.asc --export-secret-key ${KEY_ID}

# export public key
gpg --homedir ${TMP_PATH}/gpg         --output public-key.gpg --export ${KEY_ID}
gpg --homedir ${TMP_PATH}/gpg --armor --output public-key.asc --export ${KEY_ID}
