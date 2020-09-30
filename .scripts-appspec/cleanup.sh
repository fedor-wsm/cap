#!/bin/bash

echo "***Removing Old Release"
/bin/rm -rf /var/www/staging.luminode.io

echo "***Creating WWWROOT directory"
/bin/mkdir /var/www/staging.luminode.io

echo "***Cleanup stage is complete!"
