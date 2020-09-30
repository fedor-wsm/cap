#!/bin/bash

echo "***Verifying Successful Deployment.."
STATUS=$(curl -s -o /dev/null -w '%{http_code}' https://staging.luminode.io/site/login)

if [ $STATUS -eq 200 ]; then
  echo "***Deployment Successful!"
  exit 0
else
  echo "***Deployment Unsuccessful: $STATUS"
  curl -X POST --data-urlencode "payload={\"channel\": \"#luminode\", \"username\": \"Luminode-CICD Status\", \"text\": \"Luminode Web Staging deployment failed. Build will be rolled back.\", \"icon_emoji\": \":sunny:\"}" https://hooks.slack.com/services/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
  exit 1
fi
