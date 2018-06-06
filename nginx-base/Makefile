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

build: build_docker.alpine

../build/nginx.nablet: FORCE
	make -C ../ build/nginx.nablet

../build/ukvm-bin: FORCE
	make -C ../ build/ukvm-bin

../build/nabla_run: FORCE
	make -C ../ build/nabla_run

nginx.nablet: ../build/nginx.nablet
	install ../build/nginx.nablet .

ukvm-bin: ../build/ukvm-bin
	install ../build/ukvm-bin .

nabla_run: ../build/nabla_run
	install ../build/nabla_run .

FORCE:

build_docker.alpine: Dockerfile.alpine nabla_run nginx.nablet ukvm-bin
	sudo docker build -f Dockerfile.alpine -t nabla-nginx-base:alpine .
	sudo docker tag nabla-nginx-base:alpine kollerr/nabla-nginx-base:alpine

# Don't pass a mountpoint, it runs a nginx app that just prints 'Hello, Rump!!'
# It doesn't create an ISO either.
run_docker.alpine:
	sudo docker run --expose 80 --rm -it --cap-add=NET_ADMIN \
		kollerr/nabla-nginx-base:alpine \
		--volume /data:/data -- -c /data/conf/nginx.conf

clean:
	rm -f nabla_run nginx.nablet ukvm-bin