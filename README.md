# ☁️ Backups

Simple backups to an S3 bucket.

## ✨ Features

- 📦 Archive directories into dated tarballs.
- 🔄 Sync large directories directly to S3.
- 🪣 Store backups in an S3-compatible bucket.
- 🕒 Run automatically with cron.

## 🚀 Getting Started

- 📦 `/archive/*` creates dated tarballs.
- 🔄 `/sync/*` copies files directly to S3.

Define each backup as a Docker volume:

```yaml
volumes:
  - /opt/docker/vaultwarden/data:/archive/vaultwarden:ro
  - /mnt/storage/immich:/sync/immich:ro
```

These create:

```text
s3://backups/vaultwarden/YYYY-MM-DD.tar.gz
s3://backups/immich/
```

## ⏰ Schedule

Backups run daily at **01:00**.

```cron
0 1 * * *
```

## ▶️ Run Manually

In Coolify, open the deployed `backups` service terminal and run:

```bash
/app/backup
```
