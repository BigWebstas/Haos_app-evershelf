#!/bin/sh
set -e

# Keep the database, backups and runtime files on the add-on's persistent /data volume.
mkdir -p /data/backups
chown -R www-data:www-data /data
chmod -R 775 /data
rm -rf /var/www/html/data
ln -s /data /var/www/html/data
# /var/www/html is sticky: the kernel only lets www-data follow a symlink it owns.
chown -h www-data:www-data /var/www/html/data

# Scheduled jobs (the image ships no cron), run as www-data so data/ stays writable.
as_app() { su -s /bin/sh www-data -c "$1"; }

# Smart shopping list every 5 minutes. The job also takes the daily DB backup
# and the other housekeeping, so no separate backup job is needed.
(
    while :; do
        as_app "php /var/www/html/api/cron_smart_shopping.php >> /data/cron.log 2>&1" || true
        sleep 300
    done
) &

exec apache2-foreground
