# ☁️ Backups

Simple restic backups to an S3-compatible bucket.

## ✨ Features

- 📦 Back up mounted source directories with restic.
- 🔐 Encrypt backups before uploading to S3.
- 🪣 Store backups in an S3-compatible bucket.
- 🕒 Keep the last 7 daily snapshots.
- 🧹 Prune old snapshots automatically.
- ⏰ Run automatically with cron.

## 🚀 Coolify

Deploy this repository as a Docker Compose service.

- 🔐 Repository Type: `Private Repository (with GitHub App)`
- 🐙 GitHub App: `zhunio-coolify`
- 🌿 Branch: `main`
- 🐳 Build Pack: `Docker Compose`
- ⏰ Schedule: `0 1 * * *`
- 📂 Data mounts:
  - `{source}:/sources/{name}:ro`
- 🔑 Environment variables:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - `RESTIC_PASSWORD`

## 🚀 Getting Started

Add each backup path to the Docker Compose `volumes` section:

```yaml
volumes:
  - {source}:/sources/{name}:ro
```

| Source            | Target               | Behavior                            |
| ----------------- | -------------------- | ----------------------------------- |
| `/data/project-1` | `/sources/project-1` | Creates encrypted restic snapshots. |
| `/data/project-2` | `/sources/project-2` | Creates encrypted restic snapshots. |

Each source directory becomes its own restic repository:

```text
s3://backups/project-1
s3://backups/project-2
```

## ⏰ Schedule

Backups are scheduled using the `CRON` environment variable.

Default:

```text
0 1 * * *
```

## ▶️ Run Manually

In Coolify, open the deployed `backups` service terminal and run:

```bash
/app/backup
```

## 📜 Logs

Backup history is persisted on the host at:

```text
/opt/backups/logs/backups.log
```

From the service terminal:

```bash
tail -n 100 /logs/backups.log
```

Example:

```text
06/28/2026 10:39 PM [tax-report-mysql] Backup finished
06/28/2026 10:39 PM [tax-report-mysql] Prune finished
06/28/2026 10:40 PM [time-tracking-postgres] Backup finished
06/28/2026 10:40 PM [time-tracking-postgres] Prune finished
06/28/2026 10:41 PM [vaultwarden-data] Backup failed

```

## 🔁 Restore

View available snapshots:

```bash
restic -r s3:https://s3.zhunio.org/backups/{name} snapshots
```

Restore a specific snapshot:

```bash
restic -r s3:https://s3.zhunio.org/backups/{name} restore <snapshot-id> --target /sources/{name}

# Examples
restic -r s3:https://s3.zhunio.org/backups/vaultwarden restore latest --target /sources/vaultwarden

restic -r s3:https://s3.zhunio.org/backups/invoiceshelf restore latest --target /sources/invoiceshelf

restic -r s3:https://s3.zhunio.org/backups/tax-report-api restore latest --target /sources/tax-report-api
```
