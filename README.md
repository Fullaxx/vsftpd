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
Set the range of port numbers used for PASV transfers
```
-e PASVMINPORT='2000' -e PASVMAXPORT='2999'
```
Activate verbose logging
```
-e VERBOSELOG='YES'
```

## Volume Options
Place your ftp data in /srv/docker/vsftpd/ftp/
```
-v /srv/docker/vsftpd/ftp:/srv/ftp
```
Logfile is located at /log/vsftpd.log
```
-v /srv/docker/vsftpd/log:/log
```

## Run the image
Run the image using 2000-2999 as PASSIVE ports
```
docker run -d \
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
