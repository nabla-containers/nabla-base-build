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

.PHONY: rumprun-packages-hello
rumprun-packages-hello: rumprun solo5 FORCE
	install -m 664 -D $(RUMPPKGS)/config.mk.dist $(RUMPPKGS)/config.mk
	source $(RUMPRUN)/obj/config-PATH.sh && make -C $(RUMPPKGS)/hello bin/hello.seccomp
	install -m 775 -D $(RUMPPKGS)/hello/bin/hello.seccomp hello.nabla

rumprun-packages-hello-clean:
	make -C $(RUMPPKGS)/hello clean

build_docker: submodule_warning $(FILES) rumprun-packages-hello
	sudo docker build -f Dockerfile -t nabla-hello-base .
	sudo docker tag nabla-hello-base nablact/nabla-hello-base

clean:
	rm -rf hello.nabla

distclean: clean rumprun-packages-hello-clean solo5-clean rumprun-clean
