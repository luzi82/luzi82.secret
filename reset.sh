#!/bin/bash

ARG_NAME_REAL=${1}
ARG_NAME_EMAIL=${2}
ARG_NAME_COMMENT=${3}
SECRET=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64 ; echo ''`

TMP_PATH=`mktemp -d`
trap "{ rm -rf ${TMP_PATH}; }" EXIT

# create secret folder
rm -rf secret
mkdir -p secret

# create secret/gpg-gen-key
cat secret.tmpl/gpg-gen-key \
| sed --expression="s/__NAME_REAL__/${ARG_NAME_REAL}/g" \
| sed --expression="s/__NAME_EMAIL__/${ARG_NAME_EMAIL}/g" \
| sed --expression="s/__NAME_COMMENT__/${ARG_NAME_COMMENT}/g" \
| sed --expression="s/__SECRET__/${SECRET}/g" \
> secret/gpg-gen-key

# create secret/SECRET
echo ${SECRET} > secret/SECRET

# rm old key files
rm -f secret/private-key.asc
rm -f public-key.gpg
rm -f public-key.asc

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

# echo SECRET
echo ======
echo SECRET:
echo ${SECRET}
