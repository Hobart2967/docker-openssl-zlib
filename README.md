# Docker image for unpacking adb backups

Docker image pre-compiled with openssl and zlib. Ideal for uncompressing adb backups.

## Unpacking an android adb backup

```sh
docker run -v ./:/root -it hobart2967/docker-openssl-zlib dd if=myAndroidBackup.ab bs=4K iflag=skip_bytes skip=24 | openssl zlib -d > myAndroidBackup.tar
```