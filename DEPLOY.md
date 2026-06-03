# Deploy To Coolify

1. Create new `Project`: `backups`
2. Create new `Resource`
3. Select `Private Repository (with GitHub App)`
4. Select GitHub App: `coolify-deploy-zhunio`
5. Select repo: `backups`
6. Set the `Configuration`:
  - Branch: `main`
  - Build Pack: `Docker Compose`
  - Docker Compose Location: `/docker-compose.{home,vps}.yml`
7. In `General`, Set:
  - `Name`: `backups`
8. Set `Environment Variables`
9. Deploy

## Environment Variables

```text
AWS_ACCESS_KEY_ID=<email>
AWS_SECRET_ACCESS_KEY=<secret>
```
