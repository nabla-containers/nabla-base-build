# Copyright (c) 2018 Contributors as noted in the AUTHORS file
#
# Permission to use, copy, modify, and/or distribute this software
# for any purpose with or without fee is hereby granted, provided
# that the above copyright notice and this permission notice appear
# in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
# WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
# AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR
# CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
# OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
# NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
# CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

export TOP=$(abspath ..)
all: build_docker

RUMPPKGS=$(TOP)/rumprun-packages
RUMPRUN=$(TOP)/rumprun
include ../Makefile.inc

FILES=\
data/www/logo150.png \
data/www/index.html \
data/conf/mime.types \
data/conf/scgi_params \
data/conf/fastcgi_params \
data/conf/fastcgi.conf \
data/conf/uwsgi_params \
data/conf/nginx.conf \
Dockerfile \
Makefile \

.PHONY: rumprun-packages-nginx
rumprun-packages-nginx: rumprun solo5 FORCE
	install -m 664 -D $(RUMPPKGS)/config.mk.dist $(RUMPPKGS)/config.mk
	source $(RUMPRUN)/obj/config-PATH.sh && make -C $(RUMPPKGS)/nginx all bin/nginx.seccomp
	install -m 775 -D $(RUMPPKGS)/nginx/bin/nginx.seccomp nginx.nabla

rumprun-packages-nginx-clean:
	make -C $(RUMPPKGS)/nginx clean

build_docker: $(FILES) rumprun-packages-nginx
	sudo docker build -f Dockerfile -t nabla-nginx-base .
	sudo docker tag nabla-nginx-base nablact/nabla-nginx-base

clean:
	rm -rf nginx.nabla

distclean: clean rumprun-packages-nginx-clean solo5-clean rumprun-clean
