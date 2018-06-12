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

FILES=\
rootfs/etc/services \
rootfs/etc/pwd.db \
rootfs/etc/group \
rootfs/etc/nsswitch.conf \
rootfs/etc/spwd.db \
rootfs/etc/hosts \
rootfs/etc/master.passwd \
rootfs/etc/protocols \
rootfs/etc/resolv.conf \
Dockerfile \
Makefile \

all: build_docker

../build/python3.nabla: FORCE
	make -C ../ build/python3.nabla

python3.nabla: ../build/python3.nabla
	install $< .

FORCE:

# XXX: This is a temporary horrible hack which should disappear as soon as we
# fix a rumprun issue we introduced by trying to mount the root which is over
# writing rumprun's /dev devices (like random).
dev:
	mkdir -p rootfs/dev
	dd if=/dev/urandom of=rootfs/dev/urandom count=1024 bs=1024
	dd if=/dev/random of=rootfs/dev/random count=1024 bs=1024

build_docker: $(FILES) python3.nabla dev
	sudo docker build -f Dockerfile -t nabla-python3-base .
	sudo docker tag nabla-python3-base nablact/nabla-python3-base

clean:
	rm -f python3.nabla
