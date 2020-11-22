[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/luzi82/codelog.secret_manager)

```
mkdir -p ${GITPOD_REPO_ROOT}/luzi82

curl https://raw.githubusercontent.com/luzi82/codelog.web-template.1601.secret/luzi82/public-key.gpg -o ${GITPOD_REPO_ROOT}/luzi82/public-key.gpg

curl https://raw.githubusercontent.com/luzi82/codelog.web-template.1601.secret/luzi82/secret.tar.gz.gpg.sig -o ${GITPOD_REPO_ROOT}/luzi82/secret.tar.gz.gpg.sig && \
gpg --no-default-keyring --keyring ${GITPOD_REPO_ROOT}/luzi82/public-key.gpg --verify ${GITPOD_REPO_ROOT}/luzi82/secret.tar.gz.gpg.sig && \
gpg --no-default-keyring --keyring ${GITPOD_REPO_ROOT}/luzi82/public-key.gpg --decrypt ${GITPOD_REPO_ROOT}/luzi82/secret.tar.gz.gpg.sig | \
gpg --quiet --batch --yes --decrypt --passphrase="${LUZI82_SECRET}" | \
tar xzf -
```
