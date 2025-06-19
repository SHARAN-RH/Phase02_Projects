FROM alpine:3.18

RUN apk add --no-cache wget \
 && wget -O /tmp/node_exporter.tar.gz "https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz" \
 && tar xzf /tmp/node_exporter.tar.gz -C /tmp \
 && mv /tmp/node_exporter-1.6.1.linux-amd64/node_exporter /node_exporter \
 && chmod +x /node_exporter \
 && rm -rf /tmp/node_exporter.tar.gz /tmp/node_exporter-1.6.1.linux-amd64

EXPOSE 9100
ENTRYPOINT ["/node_exporter"]
