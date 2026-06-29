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
7. In `General`, set:
   - `Name`: `backups`
8. Configure the `Environment Variables`
9. Review the `volumes` in the selected Docker Compose file and mount each backup source under `/sources`
10. Deploy

## Environment Variables

```text
AWS_ACCESS_KEY_ID=<access-key>
AWS_SECRET_ACCESS_KEY=<secret-key>
RESTIC_PASSWORD=<strong-password>
```
