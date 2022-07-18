yum - y update
yum install -y epel-release
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum install -y httpd php70w php70w-mysql php70w-xml php70w-gd php70w-imap php70w-mbstring
yum install -y mariadb mariadb-server
systemctl start mariadb
systemctl enable mariadb.service
systemctl start httpd
systemctl enable httpd
yum -y update
echo ""
echo ""
echo "Lamp server instaled!!!"
echo ""