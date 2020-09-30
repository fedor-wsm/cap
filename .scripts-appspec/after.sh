#!/bin/bash

echo "***Setting up environment configuration file for app"
cd /var/www/staging.luminode.io
yes | cp -p scripts/properties/staging .env
yes | cp -p scripts/properties/staging_db.php config/db.php
yes | cp -p scripts/properties/staging_console.php config/console.php

echo "***Composer setup using the following path: `pwd`"
rm -rf vendor
COMPOSER=composer-master.json composer install
composer update
echo "***Doctrine update with force mode!"
vendor/bin/doctrine orm:schema-tool:update --force

echo "***Removing everything except these folders: vendors, snippets, demo and app"
cd web/assets
find . -maxdepth 1 -mindepth 1 \! \( -name vendors -o -name snippets -o -name demo -o -name app \) -exec rm -rf '{}' \;

echo "***Correcting permissions of /var/www/staging.luminode.io directory just in case"
chown -R apache:apache /var/www/staging.luminode.io
chmod +x /var/www/staging.luminode.io/yii
#chmod g+w /var/www/staging.luminode.io/runtime
#chmod g+w /var/www/staging.luminode.io/web/assets

echo "***After stage is complete!"
