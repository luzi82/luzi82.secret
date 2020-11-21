[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/luzi82/codelog.secret_manager)

# codelog.secret_manager

Put secret folder in github, download everywhere, protected by GnuGP.

## Example

```
# decrypt secret folder
$ ./decrypt.sh 
SECRET: (type: THIS_IS_A_SECRET)
# Folder "secret" is created
# Contains file "SECRET" and "lenna.png"

# encrypt secret folder
$ ./encrypt.sh
```

## Step

1. Fork this project.
1. Run `./reset.sh [name] [email] [comment]`.
1. Run `./encrypt.sh`.
1. Add modified `public-key.*`, `secret.tar.gz.gpg` into git and push.

## Files

* `decrypt.sh` : decryption script.
* `encrypt.sh` : encryption script.
* `secret.tar.gz.gpg` : Secret data encrypted by GnuGP.
* `secret/` : Secret folder, containing plain secret data to be protected.  Should NOT be commited to git.
* `secret/SECRET` : Secret key in plain text.

## Extra

Download secret directly and decrypt
```
# download public key, store it to ensure the signature is good.  It should not change in future.
wget https://raw.githubusercontent.com/luzi82/codelog.secret_manager/master/public-key.gpg

curl https://raw.githubusercontent.com/luzi82/codelog.secret_manager/master/secret.tar.gz.gpg.sig | \
gpg --no-default-keyring --keyring ${PWD}/public-key.gpg --decrypt | \
gpg --quiet --batch --yes --decrypt --passphrase="THIS_IS_A_SECRET" | \
tar xzf -
```
