[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/luzi82/codelog.secret_manager)

# codelog.web-template.1601.secret

This is none of your business.

## Cheatsheet

Init project
```
mkdir -p ${GITPOD_REPO_ROOT}/luzi82

curl https://raw.githubusercontent.com/luzi82/codelog.web-template.1601.secret/luzi82/public-key.gpg -o ${GITPOD_REPO_ROOT}/luzi82/public-key.gpg

cd ${GITPOD_REPO_ROOT}/luzi82 && \
curl https://raw.githubusercontent.com/luzi82/codelog.web-template.1601.secret/luzi82/secret.tar.gz.gpg.sig -o ${GITPOD_REPO_ROOT}/luzi82/secret.tar.gz.gpg.sig && \
gpg --no-default-keyring --keyring ${GITPOD_REPO_ROOT}/luzi82/public-key.gpg --verify ${GITPOD_REPO_ROOT}/luzi82/secret.tar.gz.gpg.sig && \
gpg --no-default-keyring --keyring ${GITPOD_REPO_ROOT}/luzi82/public-key.gpg --decrypt ${GITPOD_REPO_ROOT}/luzi82/secret.tar.gz.gpg.sig | \
gpg --quiet --batch --yes --decrypt --passphrase="${LUZI82_SECRET}" | \
tar xzf -

cp -R ${GITPOD_REPO_ROOT}/luzi82/secret/project-root/* ${GITPOD_REPO_ROOT}/

. ${GITPOD_REPO_ROOT}/luzi82/secret/env.sh
```

Edit luzi82 secret
```
git checkout luzi82
./decrypt_master.sh # input master secret
./decrypt_secret.sh
```

Edit sample-ci secret
```
git checkout sample-ci
./decrypt_master.sh # input master secret
./decrypt_secret.sh
```
