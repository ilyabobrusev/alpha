wget https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz
firewall-cmd --permanent --add-port=9100/tcp
firewall-cmd --reload
tar zxvf node_exporter-*.linux-amd64.tar.gz
cd node_exporter-*.linux-amd64
cp node_exporter /usr/local/bin/
useradd --no-create-home --shell /bin/false nodeusr
chown nodeusr:nodeusr /usr/local/bin/node_exporter
cat <<EOF | tee /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter Service
After=network.target

[Service]
User=nodeusr
Group=nodeusr
Type=simple
ExecStart=/usr/local/bin/node_exporter
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter
systemctl status node_exporter
