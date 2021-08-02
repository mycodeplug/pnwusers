# pnwusers

Cached DMR userdb for stations heard on PNWDigital network

## Regerating

```
PGPASSWORD=theRealDatabasePassword ./generate.sh
git add .
git commit -m "$(date +%Y-%m-%d) userdb update"
git push origin main
```
