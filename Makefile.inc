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

# These build targets are used by all rumprun-based nabla bases; their
# Makefiles include this one.

SHELL := /bin/bash

SUBMOD_NEEDS_UPDATE=$(shell [ -z "`git submodule | grep -v "^ "`" ] && echo 0 || echo 1)

ifeq ($(SUBMOD_NEEDS_UPDATE), 1)
submodule_warning:
	$(info #################################################################)
	$(info # Warning: git submodule out of date!!!!                        #)
	$(info #          Please run `git submodule update --init --recursive` #)
	$(info #################################################################)
	$(info )
	$(info Continuing in 5 seconds...)
	$(shell	sleep 5)
else
submodule_warning:

endif

libsolo5 = $(TOP)/rumprun/rumprun-solo5/rumprun-x86_64/lib/rumprun-solo5/libsolo5_seccomp.a

.PHONY: rumprun
rumprun: FORCE submodule_warning $(libsolo5)
	make -C $(TOP)/rumprun build

$(libsolo5): FORCE solo5
	install -m 664 -D $(TOP)/solo5/kernel/ukvm/solo5.o $@

rumprun-clean:
	make -C $(TOP)/rumprun clean

.PHONY: solo5
solo5: FORCE submodule_warning
	make -C $(TOP)/solo5

solo5-clean:
	make -C $(TOP)/solo5 clean

.PHONY: FORCE

