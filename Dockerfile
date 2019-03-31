# ------------------------------------------------------------------------------
# Pull base image
FROM debian:buster-slim
MAINTAINER Brett Kuskie <fullaxx@gmail.com>

# ------------------------------------------------------------------------------
# Set environment variables
ENV DEBIAN_FRONTEND noninteractive

# ------------------------------------------------------------------------------
# Install vsftpd and clean up
RUN apt-get update && apt-get install -y --no-install-recommends vsftpd && \
apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# ------------------------------------------------------------------------------
# Configure vsftpd for anonymous read-only transfers in PASV mode
RUN mkdir /log && sed \
-e 's/anonymous_enable=NO/anonymous_enable=YES/' \
-e 's/local_enable=YES/local_enable=NO/' \
-e 's/#write_enable=YES/write_enable=NO/' \
-e 's/#anon_upload_enable=YES/anon_upload_enable=NO/' \
-e 's/#anon_mkdir_write_enable=YES/anon_mkdir_write_enable=NO/' \
-e 's/#nopriv_user=ftpsecure/nopriv_user=ftp/' \
-e 's@#xferlog_file=/var/log/vsftpd.log@xferlog_file=/log/xfer.log@' \
-i /etc/vsftpd.conf && \
echo >> /etc/vsftpd.conf && \
echo "vsftpd_log_file=/log/vsftpd.log" >> /etc/vsftpd.conf && \
echo "no_anon_password=YES" >> /etc/vsftpd.conf && \
echo "pasv_enable=YES" >> /etc/vsftpd.conf && \
echo "pasv_min_port=PASVMINPORT" >> /etc/vsftpd.conf && \
echo "pasv_max_port=PASVMAXPORT" >> /etc/vsftpd.conf

# This appears to be unnecessary on x86_64
# echo "seccomp_sandbox=no" >> /etc/vsftpd.conf

# ------------------------------------------------------------------------------
# Install startup script with dockerwait
# https://github.com/Fullaxx/dockerwait
COPY app.sh dockerwait.static /app/

# ------------------------------------------------------------------------------
# Identify Volumes
VOLUME /srv/ftp
VOLUME /log

# ------------------------------------------------------------------------------
# Expose ports
EXPOSE 21

# ------------------------------------------------------------------------------
# Define runtime command
CMD ["/app/app.sh"]
