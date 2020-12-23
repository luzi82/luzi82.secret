[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/luzi82/codelog.secret_manager)

# codelog.secret_manager

Put secret folder in github, download everywhere, protected by GnuGP.

## Example

```
# decrypt secret folder
$ ./decrypt_secret.sh 
SECRET: (type: THIS_IS_A_SECRET)
# Folder "secret" is created
# Contains file "lenna.png"

# decrypt master folder
$ ./decrypt_master.sh 
MASTER_SECRET: (type: THIS_IS_A_MASTER_SECRET)
# Folder "master" is created

# encrypt secret folder
$ ./encrypt_secret.sh

# encrypt master folder
$ ./encrypt_master.sh
```

## Step

1. Fork this project.
1. Run `./reset.sh`.  `MASTER_SECRET` should be stored in safe place.
1. Create folder `secret`.  Put stuff into the folder.
1. Run `./encrypt_secret.sh`.
1. Add modified `public-key.*`, `master.tar.gz.gpg.sig`, `secret.tar.gz.gpg.sig` into git and push.

## Files

* `decrypt_master.sh` : master decryption script.
* `decrypt_secret.sh` : secret decryption script.
* `encrypt_master.sh` : master encryption script.
* `encrypt_secret.sh` : secret encryption script.
* `master.tar.gz.gpg` : Secret data encrypted by GnuGP.
* `master/` : Master secret folder, containing data of encryption key.  Should NOT be commited to git.
* `master/gpg-gen-key` : param of gpg key generation
* `master/MASTER_SECRET` : MASTER_SECRET key
* `master/private-key.asc` : GPG private key for signing, passphrase = MASTER_SECRET
* `master/SECRET` : SECRET key for sharing to trusted party
* `public-key.*` : GPG public key for verifying
* `reset.sh` : Script file to reset master folder.
* `secret.tar.gz.gpg` : Secret data encrypted by GnuGP.
* `secret/` : Secret folder, containing plain secret data to be protected.  Should NOT be commited to git.

## Extra

Download secret directly and decrypt
```
# download public key, store it to ensure the signature is good.  It should not change in future.
curl https://raw.githubusercontent.com/luzi82/codelog.secret_manager/master/public-key.gpg -o public-key.gpg

curl https://raw.githubusercontent.com/luzi82/codelog.secret_manager/master/secret.tar.gz.gpg.sig -o secret.tar.gz.gpg.sig && \
gpg --no-default-keyring --keyring ${PWD}/public-key.gpg --verify secret.tar.gz.gpg.sig && \
gpg --no-default-keyring --keyring ${PWD}/public-key.gpg --decrypt secret.tar.gz.gpg.sig | \
gpg --quiet --batch --yes --decrypt --passphrase="THIS_IS_A_SECRET" | \
tar xzf -
```
