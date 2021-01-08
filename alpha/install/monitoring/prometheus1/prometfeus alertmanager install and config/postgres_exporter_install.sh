wget https://github.com/wrouesnel/postgres_exporter/releases/download/v0.8.0/postgres_exporter_v0.8.0_linux-amd64.tar.gz
firewall-cmd --permanent --add-port=9187/tcp
firewall-cmd --reload
tar zxvf postgres_exporter-*.linux-amd64.tar.gz
cd postgres_exporter-*.linux-amd64
cp postgres_exporter /usr/local/bin/
useradd --no-create-home --shell /bin/false postgres_exporter
chown postgres_exporter:postgres_exporter /usr/local/bin/postgres_exporter
cat <<EOF | tee /etc/systemd/system/postgres_exporter.service
[Unit]
Description=Prometheus PostgreSQL Exporter
After=network.target

[Service]
Type=simple
Restart=always
User=postgres_exporter
Group=postgres_exporter
Environment=DATA_SOURCE_NAME=postgresql://postgres_exporter:@localhost:5432/postgres?sslmode=disable
ExecStart=/usr/local/bin/postgres_exporter

[Install]
WantedBy=multi-user.target

EOF
systemctl daemon-reload
systemctl enable postgres_exporter
systemctl start postgres_exporter
systemctl status postgres_exporter
