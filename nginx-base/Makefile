# Copyright (c) 2018, IBM
# Author(s): Brandon Lum, Ricardo Koller
#
# Permission to use, copy, modify, and/or distribute this software for
# any purpose with or without fee is hereby granted, provided that the
# above copyright notice and this permission notice appear in all
# copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
# WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
# AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
# DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA
# OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
# TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.

build: build_docker build_docker.alpine

../build/nginx.nablet: FORCE
	make -C ../ build/nginx.nablet

../build/ukvm-bin: FORCE
	make -C ../ build/ukvm-bin

nginx.nablet: ../build/nginx.nablet
	install $< .

ukvm-bin: ../build/ukvm-bin
	install $< .

FORCE:

build_docker: Dockerfile nginx.nablet ukvm-bin
	sudo docker build -f Dockerfile -t nabla-nginx-base .
	sudo docker tag nabla-nginx-base nablact/nabla-nginx-base

build_docker.alpine: Dockerfile.alpine nginx.nablet ukvm-bin
	sudo docker build -f Dockerfile.alpine -t nabla-nginx-base:alpine .
	sudo docker tag nabla-nginx-base:alpine nablact/nabla-nginx-base:alpine

clean:
	rm -f nginx.nablet ukvm-bin
