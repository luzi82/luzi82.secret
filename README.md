[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/luzi82/codelog.secret_manager)

```
# download public key, store it to ensure the signature is good.  It should not change in future.
curl https://raw.githubusercontent.com/luzi82/codelog.web-template.1601.secret/luzi82/public-key.gpg > public-key.gpg
gpg --import public-key.gpg

curl https://raw.githubusercontent.com/luzi82/codelog.web-template.1601.secret/luzi82/secret.tar.gz.gpg.sig | \
gpg --no-default-keyring --keyring ${PWD}/public-key.gpg --decrypt | \
gpg --quiet --batch --yes --decrypt --passphrase="${LUZI82_SECRET}" | \
tar xzf -
```
