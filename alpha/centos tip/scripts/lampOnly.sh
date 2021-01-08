yum install -y epel-release
yum install -y httpd php php-mysql php-mbstring php-mcrypt php-devel php-xml php-gd php-imap mariadb mariadb-server
systemctl start mariadb
systemctl enable mariadb.service
systemctl start httpd
systemctl enable httpd
yum -y update
echo ""
echo ""
echo "Lamp server instaled!!!"
echo ""
