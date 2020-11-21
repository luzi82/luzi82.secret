#!/bin/bash
set -e

rm -rf tmp
mkdir -p tmp

tar -czf tmp/secret.tar.gz secret
gpg --symmetric --cipher-algo AES256 --pinentry-mode loopback --passphrase-file secret/SECRET tmp/secret.tar.gz
mv tmp/secret.tar.gz.gpg ./secret.tar.gz.gpg

rm -rf tmp
