#!/bin/bash

# Make sure we're not confused by old, incompletely-shutdown httpd
# context after restarting the container.  httpd won't start correctly
# if it thinks it is already running.
rm -rf /run/httpd/* /tmp/httpd*

# configure httpd
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

# configure custom user and group
if [ "${CUSTOM_UID}" ]; then
    echo "User ohc" >> "${CONF}"
    if [ "${CUSTOM_GID}" ]; then
        groupadd -g "${CUSTOM_GID}" ohc
        useradd -r -u "${CUSTOM_UID}" -g "${CUSTOM_GID}" -d /var/www/html -s /bin/nologin ohc
        echo "Group ohc" >> "${CONF}"
    else
        useradd -r -u "${CUSTOM_UID}" -d /var/www/html -s /bin/nologin ohc
    fi
fi

exec /usr/sbin/apachectl -DFOREGROUND
