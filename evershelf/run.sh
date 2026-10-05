#!/bin/sh
set -e

# Keep the database, backups and runtime files on the add-on's persistent /data volume.
mkdir -p /data/backups
chown -R www-data:www-data /data
chmod -R 775 /data
rm -rf /var/www/html/data
ln -s /data /var/www/html/data

exec apache2-foreground
