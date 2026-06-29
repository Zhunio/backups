#!/usr/bin/env bash
set -u
set -o pipefail
shopt -s nullglob

FAILED=0

mkdir -p /logs
exec > >(tee -a /logs/backups.log) 2> >(tee -a /logs/backups.log >&2)

log() {
  echo "$(date '+%m/%d/%Y %I:%M %p') $*"
}

backup() {
  local path="$1"
  local name="${path##*/}"

  local url="https://s3.zhunio.org"
  local bucket="backups"
  local repository="s3:${url}/${bucket}/${name}"

  if ! restic -r "$repository" snapshots >/dev/null 2>&1; then
    restic -r "$repository" init
  fi

  if (
    cd "$path" &&
    restic -r "$repository" backup .
  ); then
    log "[${name}] Backup finished"
  else
    log "[${name}] Backup failed"
    FAILED=1
    return
  fi

  if restic -r "$repository" forget --keep-daily 7 --prune; then
    log "[${name}] Prune finished"
  else
    log "[${name}] Prune failed"
    FAILED=1
  fi
}

for path in /sources/*; do
  backup "$path"
done

exit "$FAILED"
