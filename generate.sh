#!/usr/bin/env bash

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

function make_csv() {
  docker run -it --network db \
      -e PGHOST=db \
      -e PGDATABASE=pnwho \
      -e PGUSER=pnwho \
      -e PGPASSWORD=$PGPASSWORD \
      -v $SCRIPTPATH/sql/$1:/sql/pg_to_csv.sql \
    postgres:12-alpine \
    bash -c 'cat /sql/pg_to_csv.sql | psql -q' > "$SCRIPTPATH/pnwusers-$2.csv"
}

if [ -z "$PGPASSWORD" ]; then
  echo "Set PGPASSWORD in the environment."
  exit 1
fi
mkdir -p "$SCRIPTPATH/prev"
cp "$SCRIPTPATH"/*.csv "$SCRIPTPATH/prev/"
make_csv pg_to_TYT_csv.sql md-uv380
make_csv pg_to_AT_csv.sql anytone-878
