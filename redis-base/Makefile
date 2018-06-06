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

../build/redis-server.nablet: FORCE
	make -C ../ build/redis-server.nablet

../build/ukvm-bin: FORCE
	make -C ../ build/ukvm-bin

../build/nabla_run: FORCE
	make -C ../ build/nabla_run

redis-server.nablet: ../build/redis-server.nablet
	install $< .

ukvm-bin: ../build/ukvm-bin
	install $< .

nabla_run: ../build/nabla_run
	install $< .

FORCE:

build_docker: Dockerfile nabla_run redis-server.nablet ukvm-bin
	sudo docker build -f Dockerfile -t nabla-redis-base .
	sudo docker tag nabla-redis-base kollerr/nabla-redis-base

build_docker.alpine: Dockerfile.alpine nabla_run redis-server.nablet ukvm-bin
	sudo docker build -f Dockerfile.alpine -t nabla-redis-base:alpine .
	sudo docker tag nabla-redis-base:alpine kollerr/nabla-redis-base:alpine

test_docker: nabla_run ukvm-bin
	# There is no /tmp in a scratch image, so we need to fake one.
	mkdir -p tmp
	sudo docker run --expose 6379 --rm -it --cap-add=NET_ADMIN \
		-v $(CURDIR)/tmp:/tmp \
		-v $(CURDIR)/nabla_run:/nabla_run \
		-v $(CURDIR)/ukvm-bin:/ukvm-bin \
		kollerr/nabla-redis-base \
		--volume /data:/data /data/conf/redis.conf

test_docker.alpine:
	sudo docker run --expose 6379 --rm -it --cap-add=NET_ADMIN \
		kollerr/nabla-redis-base:alpine \
		--volume /data:/data /data/conf/redis.conf

clean:
	rm -f nabla_run redis-server.nablet ukvm-bin
