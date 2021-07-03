[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/luzi82/codelog.secret_manager)

# luzi82.secret

None of your business.
If you want something useful, go https://github.com/luzi82/codelog.secret_manager .

## Cheatsheet

```
SECRET=...
SM_URL=https://raw.githubusercontent.com/luzi82/luzi82.secret
SM_BRANCH=codelog.websocket.luzi82

# download public key, store it to ensure the signature is good.  It should not change in future.
curl ${SM_URL}/${SM_BRANCH}/public-key.gpg -o public-key.gpg

curl ${SM_URL}/${SM_BRANCH}/secret.tar.gz.gpg.sig -o secret.tar.gz.gpg.sig && \
gpg --no-default-keyring --keyring ${PWD}/public-key.gpg --verify secret.tar.gz.gpg.sig && \
gpg --no-default-keyring --keyring ${PWD}/public-key.gpg --decrypt secret.tar.gz.gpg.sig | \
gpg --quiet --batch --yes --decrypt --passphrase="${SECRET}" | \
tar xzf -
```
