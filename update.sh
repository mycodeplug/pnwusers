#!/usr/bin/env bash

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

$SCRIPTPATH/generate.sh
git add .
git diff --cached
git commit -m "$(date +%Y-%m-%d) userdb update"
git push origin main
