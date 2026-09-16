FROM ubuntu:24.04

RUN apt-get update && apt-get install -y bc && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY server-health.sh /app/server-health.sh

RUN mkdir -p /app/logs

RUN chmod +x /app/server-health.sh

CMD ["/app/server-health.sh"]
