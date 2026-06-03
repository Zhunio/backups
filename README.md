# ☁️ Backups

Simple backups to an S3 bucket.

## ✨ Features

- 📦 Archive directories into dated tarballs.
- 🔄 Sync large directories directly to S3.
- 🪣 Store backups in an S3-compatible bucket.
- 🕒 Run automatically with cron.

## 🚀 Getting Started

Define each backup path in docker compose volumes section: {source}:{target}:ro

```yaml
volumes:
  - /data/coolify/backups/databases/root-team-0/tax-report-mysql-sc4mzxajrw40ce62k4neogvn:/archive/tax-report-mysql:ro
  - /data/coolify/backups/databases/root-team-0/time-tracking-postgres-onniddcgq2o44zz3r6hkvroy:/archive/time-tracking-postgres:ro
  - /opt/docker/vaultwarden/data:/archive/vaultwarden-data:ro
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
