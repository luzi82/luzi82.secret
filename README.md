# codelog.flask.luzi82.secret

```
curl https://raw.githubusercontent.com/luzi82/codelog.flask.luzi82.secret/master/public-key.gpg | \
gpg --import

curl https://raw.githubusercontent.com/luzi82/codelog.flask.luzi82.secret/master/secret.tar.gz.gpg.sig | \
gpg --decrypt | \
gpg --quiet --batch --yes --decrypt --passphrase="XXX" | \
tar xzf -
```
