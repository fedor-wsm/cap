#!/bin/bash

echo "***Disabling Maintenance Mode"
sed -i 's|/var/www/html|/var/www/staging.luminode.io/web|g' /etc/httpd/conf.d/staging.luminode.io.conf

echo "***Reloading Apache Service.."
if [ `pidof -s httpd` ]; then
  service httpd reload
else
  echo "***Apache is not running.., trying to run it"
  service httpd start
  if [ `pidof -s httpd` ]; then
    echo "***Apache has been started!"
  else
    echo "***Apache failed to start for some reason"
    exit 1
  fi
fi

echo "***Checking Maintenance Mode.."
STATUS=$(curl -s -o /dev/null -w '%{http_code}' https://staging.luminode.io/site/login)

if [ $STATUS -eq 200 ]; then
  echo "***Maintenance Mode has been Disabled!"
else
  echo "***Maintenance Mode has returned status: $STATUS"
  exit 1
fi

echo "***Starting supervisord (Cronjobs).."
if [ ! `pidof -s python` ]; then
  systemctl start supervisord.service
  echo "***Supervisord has been started!"
else
  echo "***Supervisord is already running.., trying to restart it.."
  systemctl restart supervisord.service
  if [ `pidof -s python` ]; then
    echo "***Supervisord has been started!"
  else
    echo "***Supervisord failed to start for some reason"
    exit 1
  fi
fi

echo "***Start stage is complete!"
