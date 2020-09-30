#!/bin/bash

echo "Creating CronJobs for magento"
if [ "$APPLICATION_NAME" == "adminCodeDeploy" ]; then
  if ! grep -q -s "SHELL" /var/spool/cron/root; then
    echo "SHELL=/bin/sh" > /var/spool/cron/root
  fi
  if ! grep -q -s "PATH" /var/spool/cron/root; then
    echo "PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin" >> /var/spool/cron/root
  fi
  if ! grep -q -s "TERM" /var/spool/cron/root; then
    echo "TERM=dumb" >> /var/spool/cron/root
  fi
  if ! grep -q -s "cron.sh" /var/spool/cron/root; then
    echo "* * * * * sudo -u nginx /bin/sh /var/www/vhosts/thecpapshop.com/public_html/cron.sh" >> /var/spool/cron/root
  fi
  if ! grep -q -s "cronfixer_error.log" /var/spool/cron/root; then
    echo "* * * * * sudo -u nginx /usr/bin/php -q /var/www/vhosts/thecpapshop.com/public_html/cron/cronfixer.php  > /var/www/vhosts/thecpapshop.com/public_html/var/log/cronfixer_error.log 2>&1" >> /var/spool/cron/root
  fi
  if ! grep -q -s "cc_add.log" /var/spool/cron/root; then
    echo "1 0 * * * sudo -u nginx /usr/bin/php -q /var/www/vhosts/thecpapshop.com/public_html/cron/cc_customer_add.php  > /var/www/vhosts/thecpapshop.com/public_html/var/log/cc_add.log 2>&1" >> /var/spool/cron/root
  fi
  if ! grep -q -s "cc_blog_add.log" /var/spool/cron/root; then
    echo "10 0 * * * sudo -u nginx /usr/bin/php -q /var/www/vhosts/thecpapshop.com/public_html/cron/cc_comment_emails.php  > /var/www/vhosts/thecpapshop.com/public_html/var/log/cc_blog_add.log 2>&1" >> /var/spool/cron/root
  fi
  if ! grep -q -s "alarm.log" /var/spool/cron/root; then
    echo "*/5 * * * * sudo -u nginx /usr/bin/php -q /var/www/vhosts/thecpapshop.com/public_html/cron/alarm_bells.php > /var/www/vhosts/thecpapshop.com/public_html/var/log/alarm.log 2>&1" >> /var/spool/cron/root
  fi
  if ! grep -q -s "refcheck.log" /var/spool/cron/root; then
    echo "0 8 * * * sudo -u nginx /usr/bin/php -q /var/www/vhosts/thecpapshop.com/public_html/cron/refchecker.php > /var/www/vhosts/thecpapshop.com/public_html/var/log/refcheck.log 2>&1" >> /var/spool/cron/root
  fi
  if ! grep -q -s "magento_acartfixes.log" /var/spool/cron/root; then
    echo "*/5 * * * *  sudo -u nginx /usr/bin/php -q  /var/www/vhosts/thecpapshop.com/public_html/cron/acart_fixes.php > /var/www/vhosts/thecpapshop.com/public_html/var/log/magento_acartfixes.log 2>&1" >> /var/spool/cron/root
  fi
  if ! grep -q -s "google_plus_email.log" /var/spool/cron/root; then
    echo "0 8 * * * sudo -u nginx /usr/bin/php -q /var/www/vhosts/thecpapshop.com/public_html/cron/three-days-ago.php > /var/www/vhosts/thecpapshop.com/public_html/var/log/google_plus_email.log 2>&1" >> /var/spool/cron/root
  fi
  if ! grep -q -s "db_checks.log" /var/spool/cron/root; then
    echo "0 * * * * sudo -u nginx /usr/bin/php -q /var/www/vhosts/thecpapshop.com/public_html/cron/db_checks.php > /var/www/vhosts/thecpapshop.com/public_html/var/log/db_checks.log 2>&1" >> /var/spool/cron/root
  fi
  if ! grep -q -s "sitemap.php" /var/spool/cron/root; then
    echo "30 15 * * * sudo -u nginx /usr/bin/php -q /var/www/vhosts/thecpapshop.com/public_html/shell/sitemap.php > /dev/null" >> /var/spool/cron/root
  fi
  if ! grep -q -s "fail_jail_cron.log" /var/spool/cron/root; then
    echo "*/5 * * * * sudo -u nginx /usr/bin/php -q /var/www/vhosts/thecpapshop.com/public_html/cron/script_jail_free.php > /var/www/vhosts/thecpapshop.com/public_html/var/log/fail_jail_cron.log 2>&1" >> /var/spool/cron/root
  fi
  if ! grep -q -s "manual_orderexport_call.php" /var/spool/cron/root; then
    echo "*/5 * * * * sudo -u nginx /usr/bin/php -q /var/www/vhosts/thecpapshop.com/public_html/cron/manual_orderexport_call.php 1 > /dev/null" >> /var/spool/cron/root
  fi
#  if ! grep -q -s "coupon_cleaner.log" /var/spool/cron/root; then
#    echo "0 0 * * * /usr/bin/php -f /var/www/vhosts/thecpapshop.com/public_html/cron/coupon_cleaner.php key=JL82535csVO889e >> /var/www/vhosts/thecpapshop.com/public_html/cron/coupon_cleaner.log" >> /var/spool/cron/root
#  fi
fi

