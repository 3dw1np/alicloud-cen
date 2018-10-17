#!/bin/bash

echo "Setup of proxy pass ..." >> /var/log/bootstrap.log 2>&1

apt-get update >> /var/log/bootstrap.log 2>&1
apt-get -y install squid3 >> /var/log/bootstrap.log 2>&1

cp /etc/squid/squid.conf /etc/squid/squid.conf.old >> /var/log/bootstrap.log 2>&1
# Squid config file
cat << EOF > /etc/squid/squid.conf
acl reverse_network src ${ALLOW_NETWORK_CIDR}
acl SSL_ports port 443
acl Safe_ports port 80          # http
acl Safe_ports port 443         # https
acl CONNECT method CONNECT
http_access deny !Safe_ports
http_access deny CONNECT !SSL_ports
http_access allow localhost manager
http_access deny manager
http_access allow localhost
http_access allow reverse_network
http_access deny all
http_port 3128 require-proxy-header
proxy_protocol_access allow reverse_network
follow_x_forwarded_for allow all
request_header_access X-Forwarded-For allow all
request_header_access Allow allow all
forwarded_for on
coredump_dir /var/spool/squid
refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern ^gopher:        1440    0%      1440
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern (Release|Packages(.gz)*)$      0       20%     2880
refresh_pattern .               0       20%     4320

EOF

service squid restart >> /var/log/bootstrap.log 2>&1

echo "End setup of proxy pass ..." >> /var/log/bootstrap.log 2>&1