 wget https://github.com/prometheus/haproxy_exporter/releases/download/v0.11.0/haproxy_exporter-0.11.0.linux-amd64.tar.gz
 firewall-cmd --permanent --add-port=9101/tcp
 firewall-cmd --reload
 tar zxvf haproxy_exporter-*.linux-amd64.tar.gz
 cd haproxy_exporter-*.linux-amd64
 cp haproxy_exporter /usr/local/bin/
 useradd --no-create-home --shell /bin/false haexpusr
 chown -R haexpusr:haexpusr /usr/local/bin/haproxy_exporter
cat <<EOF | tee /etc/systemd/system/haproxy_exporter.service
[Unit]
Description=Node Exporter Service
After=network.target

[Service]
User=haexpusr
Group=haexpusr
Type=simple
ExecStart=/usr/local/bin/haproxy_exporter --haproxy.scrape-uri="http://localhost:5000/haproxy?stats;csv"
ExecReload=/bin/kill -HUP \$MAINPID
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
 systemctl daemon-reload
 systemctl enable haproxy_exporter
 systemctl start haproxy_exporter
 systemctl status haproxy_exporter
 
 
#nano /etc/haproxy/haproxy.cfg 
#listen stats
#bind localhost:7000
#stats enable
#stats uri /haproxy?stat
