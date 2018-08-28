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

all:
	@echo "To build a base image, run 'make'"
	@echo "in the package directory."
	@echo
	@echo "To build all packages, run 'make world'."

world:
	make -C nginx-base
	make -C node-base
	make -C python3-base
	make -C redis-base
	make -C go-base

distclean:
	make -C nginx-base distclean
	make -C node-base distclean
	make -C python3-base distclean
	make -C redis-base distclean

gotest:
	make -C tests/gotest

integration: gotest
	sudo tests/bats-core/bats -p tests/integration
