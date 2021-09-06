#!/usr/bin/env bash

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

function make_csv() {
  docker run --network db \
      -e PGHOST=db \
      -e PGDATABASE=pnwho \
      -e PGUSER=pnwhoro \
      -e PGPASSWORD=$PGPASSWORD \
      -v $SCRIPTPATH/sql/$1:/sql/pg_to_csv.sql \
    postgres:12-alpine \
    bash -c 'cat /sql/pg_to_csv.sql | psql -q'
}

if [ -z "$PGPASSWORD" ]; then
  echo "Set PGPASSWORD in the environment."
  exit 1
fi
mkdir -p "$SCRIPTPATH/prev"
cp "$SCRIPTPATH"/*.csv "$SCRIPTPATH/prev/"
make_csv pg_to_TYT_csv.sql > "$SCRIPTPATH/pnwusers-md-uv380.csv"
make_csv pg_to_AT_csv.sql | awk 'sub("$", "\r")' > "$SCRIPTPATH/pnwusers-anytone-878.csv"

docker run --network db \
    -e PGHOST=db \
    -e PGDATABASE=pnwho \
    -e PGUSER=pnwhoro \
    -e PGPASSWORD=$PGPASSWORD \
    -v $SCRIPTPATH/sql/pg_to_pnwusers_json.sql:/sql/pg_to_json.sql \
  postgres:12-alpine \
  bash -c 'cat /sql/pg_to_json.sql | psql -q' > "$SCRIPTPATH/pnwusers.json"
