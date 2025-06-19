FROM debian:bookworm-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends wget tar ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Download & extract Grafana
RUN wget -O /tmp/grafana.tar.gz \
     "https://dl.grafana.com/oss/release/grafana-9.5.2.linux-amd64.tar.gz" \
 && tar -xzf /tmp/grafana.tar.gz -C /tmp \
 && mv /tmp/grafana-9.5.2 /usr/share/grafana \
 && rm /tmp/grafana.tar.gz

# Provisioning folder (copied in by Ansible)
COPY provisioning /usr/share/grafana/conf/provisioning
RUN rm -f /usr/share/grafana/conf/provisioning/datasources/sample.yaml

EXPOSE 3000

CMD ["/usr/share/grafana/bin/grafana-server", \
  "--homepath=/usr/share/grafana", \
  "--config=/usr/share/grafana/conf/defaults.ini", \
  "--packaging=tar"]
