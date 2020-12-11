useradd --no-create-home --shell /bin/false prometheus

cp redis_exporter /usr/local/bin
chown -R prometheus:prometheus /usr/local/bin/redis_exporter

cat <<EOF | tee /etc/systemd/system/redis_exporter.service
[Unit]
Description=Prometheus Redis Exporter
After=network.target

[Service]
Type=simple
Restart=always
User=prometheus
Group=prometheus
ExecStart=/usr/local/bin/redis_exporter -include-system-metrics
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable --now redis_exporter
systemctl status redis_exporter
