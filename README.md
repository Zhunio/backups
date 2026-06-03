# ☁️ Backups

Simple backups to an S3 bucket.

## ✨ Features

- 📦 Compress directories into dated tarballs.
- 🔄 Sync directories directly to S3.
- 🪣 Store backups in an S3-compatible bucket.
- 🕒 Run automatically with cron.

## 🚀 Getting Started

Add each backup path to the docker compose `volumes` section:

```yaml
volumes:
  - {source}:{target}:ro
```

| Source          | Target            | Mode      | Behavior                         |
| --------------- | ----------------- | --------- | -------------------------------- |
| /data/project-1 | `/archive/{name}` | `archive` | Creates dated tarballs.          |
| /data/project-2 | `/sync/{name}`    | `sync`    | Mirrors large directories to S3. |

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
