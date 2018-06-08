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

../build/python3.nablet: FORCE
	make -C ../ build/python3.nablet

../build/ukvm-bin: FORCE
	make -C ../ build/ukvm-bin

python3.nablet: ../build/python3.nablet
	install $< .

ukvm-bin: ../build/ukvm-bin
	install $< .

FORCE:

build_docker: Dockerfile python3.nablet ukvm-bin
	sudo docker build -f Dockerfile -t nabla-python3-base .
	sudo docker tag nabla-python3-base nablact/nabla-python3-base

clean:
	rm -f python3.nablet ukvm-bin
