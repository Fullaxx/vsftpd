# A small docker image running vsftpd

## Base Docker Image
[Debian](https://hub.docker.com/_/debian) Buster (x64)

## Software
[vsftpd](https://security.appspot.com/vsftpd.html) - A GPL licensed FTP server

## About the image
The goal of this image is to provide quick and easy access to files served over FTP \
The server is restricted to read-only transfers by the anonymous user \
The anonymous user has no password and no other user will be allowed to connect \
The configuration of this server will not allow uploads of any kind

## Get the image from Docker Hub
```
docker pull fullaxx/vsftpd
```

## Configuration Options
Set the range of port numbers used for passive transfers
```
-e PASVMINPORT='2000' -e PASVMAXPORT='2999'
```
Activate verbose logging (/log/vsftpd.log)
```
-e VERBOSELOG='YES'
```
Activate transfer log (/log/xfer.log)
```
-e XFERLOG='YES'
```
If you are using host networking \
You can specify a specific IP address to bind to
```
--network=host -e LISTENIP4=76.51.51.84
<or>
--network=host -e LISTENIP6=2001:4860:4860::8888
```

## Volume Options
Place your ftp data in /srv/docker/vsftpd/ftp/ \
vsftpd will serve your data from /srv/ftp
```
-v /srv/docker/vsftpd/ftp:/srv/ftp
```
vsftpd will create your log files in /log/ \
You may find them under /srv/docker/vsftpd/log/
```
-v /srv/docker/vsftpd/log:/log
```

## Run the image
Run the image using 2000-2999 as passive ports
```
docker run -d \
-e PASVMINPORT='2000' -e PASVMAXPORT='2999' \
-p 21:21 -p 2000-2999:2000-2999 \
-v /srv/docker/vsftpd/ftp:/srv/ftp \
-v /srv/docker/vsftpd/log:/log \
fullaxx/vsftpd
```
Run the image using 2000-2999 as passive ports and enable all logging options
```
docker run -d \
-e XFERLOG='YES' -e VERBOSELOG='YES' \
-e PASVMINPORT='2000' -e PASVMAXPORT='2999' \
-p 21:21 -p 2000-2999:2000-2999 \
-v /srv/docker/vsftpd/ftp:/srv/ftp \
-v /srv/docker/vsftpd/log:/log \
fullaxx/vsftpd
```

## Build it locally using the github repository
```
docker build -t="fullaxx/vsftpd" github.com/Fullaxx/vsftpd
```
