wget https://github.com/prometheus/prometheus/releases/download/v2.31.1/prometheus-2.31.1.linux-amd64.tar.gz
firewall-cmd --permanent --add-port={9090,9093,9094,9100}/tcp --add-port=9094/udp
firewall-cmd --reload
firewall-cmd --list-all
mkdir /etc/prometheus/
mkdir /var/lib/prometheus/
tar zxvf prometheus-*.linux-amd64.tar.gz
cp prometheus-*.linux-amd64/{prometheus,promtool} /usr/local/bin/
cp prometheus-*.linux-amd64/prometheus.yml /etc/prometheus/
cp -r prometheus-*.linux-amd64/console* /etc/prometheus/
useradd --no-create-home --shell /bin/false prometheus
chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus/
chown prometheus:prometheus /usr/local/bin/{prometheus,promtool}
cat <<EOF | tee /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus Service
After=network.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
--config.file /etc/prometheus/prometheus.yml \
--storage.tsdb.path /var/lib/prometheus/ \
--storage.tsdb.retention.time=7d \
--web.console.templates=/etc/prometheus/consoles \
--web.console.libraries=/etc/prometheus/console_libraries \
--web.enable-admin-api
ExecReload=/bin/kill -HUP \$MAINPID
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable --now prometheus
systemctl status prometheus
