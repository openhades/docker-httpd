#!/bin/bash

# Make sure we're not confused by old, incompletely-shutdown httpd
# context after restarting the container.  httpd won't start correctly
# if it thinks it is already running.
rm -rf /run/httpd/* /tmp/httpd*

# enable htaccess
if [ "${HTTPD_HTACCESS}" ]; then
cat > /etc/httpd/conf.d/99-httpd-htaccess.conf << EOF
<Directory "/var/www/html">
    AllowOverride All
</Directory>
EOF
fi

exec /usr/sbin/apachectl -DFOREGROUND

