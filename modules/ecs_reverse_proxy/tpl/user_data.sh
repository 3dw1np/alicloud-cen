#!/bin/bash

echo "Setup of proxy reverse ..." >> /var/log/bootstrap.log 2>&1

apt-get update >> /var/log/bootstrap.log 2>&1
apt-get -y install nginx >> /var/log/bootstrap.log 2>&1

# Nginx config file
cat << EOF > /etc/nginx/sites-available/reverse_proxy.conf
upstream @squid {
	server ${PROXY_PASS_IP}:3128;
}

server {
	listen 80;

	location / {
		proxy_pass http://@squid;

		proxy_set_header Host \$host;
		proxy_set_header X-Real-IP \$remote_addr;
		proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
		proxy_set_header X-Forwarded-Proto \$scheme;
		proxy_set_header Request-URI \$request_uri;
		proxy_connect_timeout	10;
		proxy_send_timeout	30;
		proxy_read_timeout	30;

		proxy_redirect		off;

		access_log /var/log/nginx/reverse_proxy-access.log;
		error_log /var/log/nginx/reverse_proxy-error.log;
	}
}
EOF

rm /etc/nginx/sites-available/default >> /var/log/bootstrap.log 2>&1
ln -s /etc/nginx/sites-available/reverse_proxy.conf /etc/nginx/sites-enabled/reverse_proxy.conf >> /var/log/bootstrap.log 2>&1
service nginx restart >> /var/log/bootstrap.log 2>&1

echo "End setup of proxy reverse ..." >> /var/log/bootstrap.log 2>&1