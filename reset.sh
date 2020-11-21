#!/bin/bash
set -e

TMP_PATH=`mktemp -d`
trap "{ rm -rf ${TMP_PATH}; }" EXIT

# random secret
SECRET=''
for _ in {1..3}; do
  SECRET=${SECRET}`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64`
done
# SECRET="THIS_IS_A_SECRET"

MASTER_SECRET=''
for _ in {1..3}; do
  MASTER_SECRET=${MASTER_SECRET}`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64`
done

# Ask arg
read -p "KEY NAME: " ARG_NAME_REAL
read -p "KEY EMAIL: " ARG_NAME_EMAIL
read -p "KEY COMMENT: " ARG_NAME_COMMENT
#read -sp "MASTER_SECRET: " ARG_MASTER_SECRET

# rm old files
rm -rf master
rm -f public-key.gpg
rm -f public-key.asc

# reset master folder
mkdir -p master

# create secret/gpg-gen-key
NAME_REAL_E=$(printf '%s\n' "${ARG_NAME_REAL}" | sed -e 's/[]\/$*.^[]/\\&/g')
NAME_EMAIL_E=$(printf '%s\n' "${ARG_NAME_EMAIL}" | sed -e 's/[]\/$*.^[]/\\&/g')
NAME_COMMENT_E=$(printf '%s\n' "${ARG_NAME_COMMENT}" | sed -e 's/[]\/$*.^[]/\\&/g')
cat master.tmpl/gpg-gen-key \
| sed --expression="s/__NAME_REAL__/${NAME_REAL_E}/g" \
| sed --expression="s/__NAME_EMAIL__/${NAME_EMAIL_E}/g" \
| sed --expression="s/__NAME_COMMENT__/${NAME_COMMENT_E}/g" \
| sed --expression="s/__MASTER_SECRET__/${MASTER_SECRET}/g" \
> master/gpg-gen-key

# create master/SECRET
echo ${SECRET} > master/SECRET

# create master/MASTER_SECRET
echo ${MASTER_SECRET} > master/MASTER_SECRET

# create gpg folder
mkdir -p ${TMP_PATH}/gpg
chmod 700 ${TMP_PATH}/gpg

# create gpg key pair
gpg --homedir ${TMP_PATH}/gpg --batch --gen-key ${PWD}/master/gpg-gen-key

# export private key
gpg --homedir ${TMP_PATH}/gpg --batch --pinentry-mode loopback --passphrase-file master/MASTER_SECRET --armor --output master/private-key.asc --export-secret-key ${ARG_NAME_EMAIL}

# export public key
gpg --homedir ${TMP_PATH}/gpg         --output public-key.gpg --export ${ARG_NAME_EMAIL}
gpg --homedir ${TMP_PATH}/gpg --armor --output public-key.asc --export ${ARG_NAME_EMAIL}

# create secret pack
./encrypt_master.sh

# echo secret
echo ======
echo SECRET
cat master/SECRET
echo ======
echo MASTER_SECRET
cat master/MASTER_SECRET
