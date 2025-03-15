.PHONY: build clean download-nginx build-nginx configure build-module run debug

build: clean download-nginx build-nginx

download-nginx:
	curl https://nginx.org/download/nginx-1.27.4.tar.gz > nginx.tar.gz
	tar -zxvf nginx.tar.gz

configure:
	cd nginx-1.27.4 && ./configure --prefix=$(PWD)/build --add-dynamic-module=..

build-nginx: configure
	cd nginx-1.27.4 && make && make install

build-module:
	cd nginx-1.27.4 && make modules && make install

clean:
	rm -rf nginx-1.27.4
	rm -rf nginx.tar.gz

run:
	./build/sbin/nginx -c $(PWD)/nginx.conf
