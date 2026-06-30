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

## ⚙️ Backup Configuration

### 📂 Volumes

Add each directory to back up as a read-only mount under `/sources`.

```yaml
volumes:
  - {source}:/sources/{name}:ro
```

Example:

```yaml
volumes:
  - /opt/vaultwarden:/sources/vaultwarden:ro
  - /opt/invoiceshelf:/sources/invoiceshelf:ro
  - /opt/tax-report-api:/sources/tax-report-api:ro
  - /opt/time-tracking-api:/sources/time-tracking-api:ro
```

Each mounted source becomes its own Restic repository:

```text
s3://backups/vaultwarden
s3://backups/invoiceshelf
s3://backups/tax-report-api
s3://backups/time-tracking-api
```

### ⏰ Schedule

Configure the backup schedule using the `CRON` environment variable.

Default:

```tex
0 1 * * *
```

### ▶️ Run Manually

Run a backup from the service terminal:

```bash
/app/backup
```

## 🔁 Restore

1. ✏️ Temporarily remove `:ro` from the volume being restored and recreate the service.

2. 🔎 View available snapshots.

   ```bash
   restic -r s3:https://s3.zhunio.org/backups/{name} snapshots
   ```

3. ☁️ Restore a snapshot.

   ```bash
   restic -r s3:https://s3.zhunio.org/backups/{name} restore <snapshot-id> --target /sources/{name}
   ```

   Example:

   ```bash
   restic -r s3:https://s3.zhunio.org/backups/vaultwarden restore latest --target /sources/vaultwarden

   restic -r s3:https://s3.zhunio.org/backups/invoiceshelf restore latest --target /sources/invoiceshelf

   restic -r s3:https://s3.zhunio.org/backups/tax-report-api restore latest --target /sources/tax-report-api

   restic -r s3:https://s3.zhunio.org/backups/time-tacking-api restore latest --target /sources/time-tracking-api
   ```

4. 🔒 Add `:ro` back to the volume and recreate the service.

## 📜 Logs

Backup history is stored at:

```text
/opt/backups/logs/backups.log
```

Example:

```text
06/28/2026 10:39 PM [tax-report-mysql] Backup finished
06/28/2026 10:39 PM [tax-report-mysql] Prune finished
06/28/2026 10:40 PM [time-tracking-postgres] Backup finished
06/28/2026 10:40 PM [time-tracking-postgres] Prune finished
06/28/2026 10:41 PM [vaultwarden-data] Backup failed
```
