wget https://github.com/danielqsj/kafka_exporter/releases/download/v1.3.1/kafka_exporter-1.3.1.linux-amd64.tar.gz
firewall-cmd --permanent --add-port=9308/tcp
firewall-cmd --reload
tar zxvf kafka_exporter-1.3.1.linux-amd64.tar.gz
cp kafka_exporter-1.3.1.linux-amd64/kafka_exporter /usr/local/bin/
useradd --no-create-home --shell /bin/false kafka_exporter
cat <<EOF | tee /etc/systemd/system/kafka_exporter.service
[Unit]
Description=Kafka Exporter Service
After=network.target
Requires=kafka.service

[Service]
User=kafka_exporter
Group=kafka_exporter
Type=simple
ExecStart=/usr/local/bin/kafka_exporter --kafka.server=localhost:9092
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable --now kafka_exporter
systemctl status kafka_exporter