FROM ubuntu:16.04

RUN apt-get update &&\
	apt-get -y remove openssl &&\
	apt-get -y install build-essential zlib1g-dev &&\
	apt-get -q update && apt-get -qy install wget make &&\
	wget https://www.openssl.org/source/openssl-3.0.5.tar.gz &&\
	tar -xzvf openssl-3.0.5.tar.gz &&\
	cd openssl-3.0.5 &&\
	./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib &&\
	make &&\
	make install

RUN cat <<'EOT' | tee /etc/ld.so.conf.d/openssl-3.0.5.conf
/usr/local/ssl/lib64
EOT


RUN ldconfig -v &&\
	mv /usr/bin/openssl /usr/bin/openssl.bak &&\
	mv /usr/bin/c_rehash /usr/bin/c_rehash.bak &&\
	update-alternatives --install /usr/bin/openssl openssl /usr/local/ssl/bin/openssl 1 &&\
	update-alternatives --install /usr/bin/c_rehash c_rehash /usr/local/ssl/bin/c_rehash 1