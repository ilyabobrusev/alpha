firewall-cmd --permanent --add-port=9113/tcp
firewall-cmd --reload
tar zxvf nginx-prometheus-exporter_*_linux_amd64.tar.gz
cp nginx-prometheus-exporter_*_linux_amd64/nginx-prometheus-exporter /usr/local/bin/
useradd --no-create-home --shell /bin/false nginx-prometheus-exporter
chown nginx-prometheus-exporter:nginx-prometheus-exporter /usr/local/bin/nginx-prometheus-exporter
cat <<EOF | tee /etc/systemd/system/nginx-prometheus-exporter.service
[Unit]
Description=nginx-prometheus-exporter service
After=network.target

[Service]
User=nginx-prometheus-exporter
Group=nginx-prometheus-exporter
Type=simple
ExecStart=/usr/local/bin/nginx-prometheus-exporter -nginx.scrape-uri=http://localhost/basic_status
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable --now nginx-prometheus-exporter
systemctl status nginx-prometheus-exporter
