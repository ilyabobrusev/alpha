wget https://github.com/google/cadvisor/releases/download/v0.37.0/cadvisor
firewall-cmd --permanent --add-port=8080/tcp
firewall-cmd --reload
cp cadvisor /usr/local/bin/
useradd --no-create-home --shell /bin/false cadvisor
chown -R cadvisor:cadvisor /usr/local/bin/cadvisor
chmod 755 /usr/local/bin/cadvisor
cat <<EOF | tee /etc/systemd/system/cadvisor.service
[Unit]
Description=Cadvisor Service
After=network.target

[Service]
User=nodeusr
Group=nodeusr
Type=simple
ExecStart=/usr/local/bin/cadvisor
ExecReload=/bin/kill -HUP \$MAINPID
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable cadvisor
systemctl start cadvisor
systemctl status cadvisor
