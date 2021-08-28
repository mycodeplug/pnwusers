#!/usr/bin/env bash

set -euo pipefail

MIN_DATA_SIZE=3000000

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

$SCRIPTPATH/generate.sh
data_size=$(wc -c pnwusers* | tail -n 1 | cut -d ' ' -f 1)
if [[ $data_size -lt $MIN_DATA_SIZE ]]; then
  echo "Total bytes generated, $data_size, is less than threshold $MIN_DATA_SIZE"
  git reset --hard origin/main
  exit 1
fi
git add .
git commit <<< "$(date +%Y-%m-%d) userdb update\n\n$(git diff --summary --stat --no-patch)"
git push origin main
