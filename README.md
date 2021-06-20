[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/luzi82/codelog.secret_manager)

# luzi82.secret

None of your business.
If you want something useful, go https://github.com/luzi82/codelog.secret_manager .

## Cheatsheet

```
SECRET=${LUZI82_SECRET}
SM_URL=https://raw.githubusercontent.com/luzi82/luzi82.secret
SM_BRANCH=codelog.web-template.1601.luzi82

cd ${GITPOD_REPO_ROOT}
mkdir -p ${GITPOD_REPO_ROOT}/luzi82

# download public key, store it to ensure the signature is good.  It should not change in future.
cd ${GITPOD_REPO_ROOT}
curl ${SM_URL}/${SM_BRANCH}/public-key.gpg -o ${GITPOD_REPO_ROOT}/luzi82/public-key.gpg

curl ${SM_URL}/${SM_BRANCH}/secret.tar.gz.gpg.sig -o ${GITPOD_REPO_ROOT}/luzi82/secret.tar.gz.gpg.sig && \
gpg --no-default-keyring --keyring ${GITPOD_REPO_ROOT}/luzi82/public-key.gpg --verify ${GITPOD_REPO_ROOT}/luzi82/secret.tar.gz.gpg.sig && \
gpg --no-default-keyring --keyring ${GITPOD_REPO_ROOT}/luzi82/public-key.gpg --decrypt ${GITPOD_REPO_ROOT}/luzi82/secret.tar.gz.gpg.sig | \
gpg --quiet --batch --yes --decrypt --passphrase="${SECRET}" | \
tar xzf -

cp -R ${GITPOD_REPO_ROOT}/secret/project-root/* ${GITPOD_REPO_ROOT}/

. ${GITPOD_REPO_ROOT}/secret/env.sh
```
