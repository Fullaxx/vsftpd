#!/bin/bash

sed \
-e "s/PASVMINPORT/${PASVMINPORT}/" \
-e "s/PASVMAXPORT/${PASVMAXPORT}/" \
-i /etc/vsftpd.conf

/etc/init.d/vsftpd start

exec /app/dockerwait.static
