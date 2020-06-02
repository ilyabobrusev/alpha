iptables -F
iptables -I INPUT -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -I INPUT -p tcp --dport 80 -m state --state NEW -j ACCEPT
iptables -I INPUT -p tcp --dport 443 -m state --state NEW -j ACCEPT
iptables -I INPUT -p tcp --dport 25 -m state --state NEW -j ACCEPT
service iptables save
iptables-save > /etc/iptables.rules
service iptables restart
echo ""
echo ""
echo "Settings applied!!!"
echo ""