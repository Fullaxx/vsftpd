#!/bin/bash

if [ -n "${LISTENIP4}" ]; then
  sed \
    -e "s/listen=NO/listen=YES\nlisten_address=${LISTENIP4}/" \
    -e "s/listen_ipv6=YES/listen_ipv6=NO/" \
    -i /etc/vsftpd.conf
elif [ -n "${LISTENIP6}" ]; then
  sed \
    -e "s/listen_ipv6=YES/listen_ipv6=YES\nlisten_address6=${LISTENIP6}/" \
    -i /etc/vsftpd.conf
fi

sed \
-e "s/PASVMINPORT/${PASVMINPORT}/" \
-e "s/PASVMAXPORT/${PASVMAXPORT}/" \
-i /etc/vsftpd.conf

if [ "${VERBOSELOG}" == "YES" ]; then
  echo "log_ftp_protocol=YES" >> /etc/vsftpd.conf
fi

if [ "${XFERLOG}" == "YES" ]; then
  echo "dual_log_enable=YES" >> /etc/vsftpd.conf
fi

/etc/init.d/vsftpd start

exec /app/dockerwait.static
