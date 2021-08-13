wget https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v0.9.0/nginx-prometheus-exporter_0.9.0_linux_amd64.tar.gz
firewall-cmd --permanent --add-port=9113/tcp
firewall-cmd --reload
tar zxvf nginx-prometheus-exporter_0.9.0_linux_amd64.tar.gz
cp nginx-prometheus-exporter /usr/local/bin/
useradd --no-create-home --shell /bin/false nginx-prometheus-exporter
chown nginx-prometheus-exporter:nginx-prometheus-exporter /usr/local/bin/nginx-prometheus-exporter
cat <<EOF | tee /etc/systemd/system/nginx-prometheus-exporter.service
[Unit]
Description=nginx-prometheus-exporter service
After=nginx.service

[Service]
User=nginx-prometheus-exporter
Group=nginx-prometheus-exporter
Type=simple
ExecStart=/usr/local/bin/nginx-prometheus-exporter -nginx.scrape-uri=http://127.0.0.1/basic_status
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable --now nginx-prometheus-exporter
systemctl status nginx-prometheus-exporter