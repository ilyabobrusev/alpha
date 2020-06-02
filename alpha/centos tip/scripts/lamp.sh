echo "127.0.0.1    host.local" >> /etc/hosts
yum install -y httpd
yum install -y php php-mysql php-mbstring php-mcrypt php-devel php-xml php-gd epel-release* php-imap*
yum install -y mariadb mariadb-server
systemctl start mariadb
systemctl enable mariadb.service
systemctl start httpd
systemctl enable httpd
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --reload
yum -y update
echo ""
echo ""
echo "Lamp server instaled!!!"
echo ""