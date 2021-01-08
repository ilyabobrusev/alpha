echo "[Webmin]" >> /etc/yum.repos.d/webmin.repo
echo "name=Webmin Distribution Neutral" >> /etc/yum.repos.d/webmin.repo
echo "mirrorlist=http://download.webmin.com/download/yum/mirrorlist" >> /etc/yum.repos.d/webmin.repo
echo "enabled=1" >> /etc/yum.repos.d/webmin.repo
rpm --import http://www.webmin.com/jcameron-key.asc
yum install -y webmin
chkconfig webmin on
echo ""
echo ""
echo "Webmin instaled!!!"
echo ""