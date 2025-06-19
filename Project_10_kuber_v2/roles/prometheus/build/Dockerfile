FROM alpine:3.18

RUN apk add --no-cache wget \
 && wget -O /tmp/prom.tar.gz \
      "https://github.com/prometheus/prometheus/releases/download/v2.52.0/prometheus-2.52.0.linux-amd64.tar.gz" \
 && tar xzf /tmp/prom.tar.gz -C /tmp \
 && mv /tmp/prometheus-2.52.0.linux-amd64/prometheus /bin/prometheus \
 && mv /tmp/prometheus-2.52.0.linux-amd64/promtool /bin/promtool \
 && mkdir -p /etc/prometheus /prometheus \
 && mv /tmp/prometheus-2.52.0.linux-amd64/consoles /etc/prometheus/ \
 && mv /tmp/prometheus-2.52.0.linux-amd64/console_libraries /etc/prometheus/ \
 && rm -rf /tmp/prom.tar.gz /tmp/prometheus-2.52.0.linux-amd64

COPY prometheus.yml /etc/prometheus/prometheus.yml

EXPOSE 9090
ENTRYPOINT ["/bin/prometheus", \
  "--config.file=/etc/prometheus/prometheus.yml", \
  "--storage.tsdb.path=/prometheus"]
