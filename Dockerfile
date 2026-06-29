FROM alpine:latest

RUN apk add --no-cache bash restic tzdata

ENV TZ=America/New_York
ENV CRON="0 2 * * *"

COPY backup.sh /app/backup

RUN chmod +x /app/backup

CMD sh -c 'echo "$CRON /app/backup >> /proc/1/fd/1 2>> /proc/1/fd/2" > /etc/crontabs/root && crond -f -l 2 -c /etc/crontabs'
