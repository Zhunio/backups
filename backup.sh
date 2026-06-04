#!/usr/bin/env bash
set -u
set -o pipefail
shopt -s nullglob

FAILED=0
mkdir -p /logs && exec > >(tee -a /logs/backups.log) 2> >(tee -a /logs/backups.log >&2)

s3() {
  local mode="$1"
  local backup="$2"
  local target

  if [ "$mode" = "archive" ]; then
    target="s3://backups/${backup##*/}/$(date +%F).tar.gz"
    tar -C "$backup" -czf - . | aws s3 cp - "$target" --endpoint-url "https://s3.zhunio.org" --only-show-errors
  else
    target="s3://backups/${backup##*/}/"
    aws s3 sync "$backup" "$target" --endpoint-url "https://s3.zhunio.org" --only-show-errors
  fi

  if [ "$?" -eq 0 ]; then
    echo "[$(date -Is)] Backup succeeded: ${backup} -> ${target}"
  else
    echo "[$(date -Is)] Backup failed: ${backup} -> ${target}" >&2
    FAILED=1
  fi
}

for backup in /archive/*; do
  s3 archive "$backup"
done

for backup in /sync/*; do
  s3 sync "$backup"
done

exit "$FAILED"
