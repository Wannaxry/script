chown -R www-data:www-data /usr/share/nextcloud 
chown -R www-data:www-data /usr/share/nextcloud/data
find /usr/share/nextcloud/ -type d -exec chmod 750 {} \; 
find /usr/share/nextcloud/ -type f -exec chmod 640 {} \; 
find /usr/share/nextcloud/data -type d -exec chmod 750 {} \; 
find /usr/share/nextcloud/data -type f -exec chmod 640 {} \; 
