#!/bin/bash

sed \
-e "s/PASVMINPORT/${PASVMINPORT}/" \
-e "s/PASVMAXPORT/${PASVMAXPORT}/" \
-i /etc/vsftpd.conf

if [ "${VERBOSELOG}" == "YES" ]; then
  echo "log_ftp_protocol=YES" >> /etc/vsftpd.conf
fi

if [ "${DUALLOG}" == "YES" ]; then
  echo "dual_log_enable=YES" >> /etc/vsftpd.conf
fi

/etc/init.d/vsftpd start

exec /app/dockerwait.static
