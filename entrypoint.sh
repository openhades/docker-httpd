#!/bin/bash

# Make sure we're not confused by old, incompletely-shutdown httpd
# context after restarting the container.  httpd won't start correctly
# if it thinks it is already running.
rm -rf /run/httpd/* /tmp/httpd*

CONF="/etc/httpd/conf.d/99-httpd-docker.conf"
> "${CONF}" 

# enable htaccess
if [ "${HTTPD_HTACCESS}" ]; then
cat >> "${CONF}" << EOF
<Directory "/var/www/html">
    AllowOverride All
</Directory>
EOF
fi

# configure custom user
if [ "${CUSTOM_UID}" ]; then
    echo "User #${CUSTOM_UID}" >> "${CONF}"
fi

# configure custom user
if [ "${CUSTOM_GID}" ]; then
    echo "Group #${CUSTOM_GID}" >> "${CONF}"
fi

exec /usr/sbin/apachectl -DFOREGROUND
