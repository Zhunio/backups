FROM alpine:latest

RUN apk add --no-cache bash aws-cli tar tzdata

ENV TZ=America/New_York

COPY backup.sh /app/backup

RUN chmod +x /app/backup

RUN echo '0 21 * * * /app/backup >> /proc/1/fd/1 2>> /proc/1/fd/2' > /etc/crontabs/root

HEALTHCHECK CMD test "$(cat /etc/crontabs/root)" = "0 21 * * * /app/backup >> /proc/1/fd/1 2>> /proc/1/fd/2"

CMD ["crond", "-f", "-l", "2", "-c", "/etc/crontabs"]
