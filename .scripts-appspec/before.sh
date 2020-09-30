#!/bin/bash

echo "$DEPLOYMENT_GROUP_NAME has started!"

echo "***Enabling Maintenance Mode"
sed -i 's|/var/www/staging.luminode.io/web|/var/www/html|g' /etc/httpd/conf.d/staging.luminode.io.conf

echo "***Reloading Apache Service.."
if [ `pidof -s httpd` ]; then
  service httpd reload
  echo "***Apache has been restarted!"
else
  echo "***Apache is not running.., trying to run it"
  service httpd start
  if [ `pidof -s httpd` ]; then
    echo "***Apache has been started!"
  else
    echo "***Apache failed to start for some reason."
    exit 1
  fi
fi

echo "***Checking Maintenance Mode.."
STATUS=$(curl -s -o /dev/null -w '%{http_code}' https://staging.luminode.io)

if [ $STATUS -eq 200 ]; then
  echo "***Maintenance Mode is Enabled!"
else
  echo "***Maintenance Mode has returned status: $STATUS"
  exit 1
fi

echo "***Stopping supervisord (Cronjobs).."
if [ `pidof -s python` ]; then
  systemctl stop supervisord.service
  echo "***Supervisord has been stopped!"
else
  echo "***Supervisord is not running"
fi

echo "***Before stage is complete!"
