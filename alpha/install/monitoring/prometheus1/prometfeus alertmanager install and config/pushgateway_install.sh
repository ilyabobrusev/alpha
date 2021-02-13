wget https://github.com/prometheus/pushgateway/releases/download/v1.4.0/pushgateway-1.4.0.linux-amd64.tar.gz
firewall-cmd --permanent --add-port=9091/tcp
firewall-cmd --reload
tar zxvf pushgateway-*.tar.gz
cp pushgateway-*/pushgateway /usr/local/bin/
useradd --no-create-home --shell /bin/false pushgateway
chown pushgateway:pushgateway /usr/local/bin/pushgateway
cat <<EOF | tee /etc/systemd/system/pushgateway.service
[Unit]
Description=Pushgateway Service
After=network.target

[Service]
User=pushgateway
Group=pushgateway
Type=simple
ExecStart=/usr/local/bin/pushgateway \
    --web.listen-address=":9091" \
    --web.telemetry-path="/metrics" \
    --persistence.file="/tmp/metric.store" \
    --persistence.interval=5m \
    --log.level="info" \
    --log.format="json"
ExecReload=/bin/kill -HUP \$MAINPID
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable --now pushgateway
systemctl status pushgateway
