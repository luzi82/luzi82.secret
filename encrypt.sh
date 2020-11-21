#!/bin/bash
set -e

rm -rf secret.tar.gz.gpg

tar czf - secret | \
gpg --symmetric --cipher-algo AES256 --pinentry-mode loopback --passphrase-file secret/SECRET --output secret.tar.gz.gpg
