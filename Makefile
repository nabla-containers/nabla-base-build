default: build

.PHONY: submodules
submodules:
	git submodule update --init

build: build/node.nablet build/ukvm-bin build/nabla_run

test: test-node

SOLO5_OBJ=solo5/kernel/ukvm/solo5.o

solo5: $(SOLO5_OBJ) solo5/ukvm/ukvm-bin

$(SOLO5_OBJ):
	UKVM_STATIC=yes make -C solo5 ukvm

solo5/ukvm/ukvm-bin:
	UKVM_STATIC=yes make -C solo5/ukvm

RUMP_SOLO5_X86_64=rumprun/rumprun-solo5/rumprun-x86_64
RUMP_SOLO5_SECCOMP=$(RUMP_SOLO5_X86_64)/lib/rumprun-solo5/libsolo5_seccomp.a
RUMP_LIBC=$(RUMP_SOLO5_X86_64)/lib/libc.a

rumprun: $(RUMP_SOLO5_SECCOMP) $(RUMP_LIBC)

$(RUMP_LIBC):
	cd rumprun && git submodule update --init
	make -C rumprun build

$(RUMP_SOLO5_SECCOMP): $(SOLO5_OBJ)
	install -m 664 -D $(SOLO5_OBJ) $@

rumprun-packages/config.mk:
	install -m 664 -D rumprun-packages/config.mk.dist $@

SHELL := /bin/bash

rumprun-packages/nodejs/node.seccomp: $(RUMP_SOLO5_SECCOMP) $(RUMP_LIBC) rumprun-packages/config.mk
	source rumprun/obj/config-PATH.sh && make -C rumprun-packages/nodejs node.seccomp

NABLA_RUN=nabla-build/nabla-run/cli/nabla_run/nabla_run

$(NABLA_RUN):
	make -C nabla-build build

build/node.nablet: rumprun-packages/nodejs/node.seccomp
	install -m 775 -D rumprun-packages/nodejs/node.seccomp $@

build/ukvm-bin: solo5/ukvm/ukvm-bin
	install -m 775 -D solo5/ukvm/ukvm-bin $@

build/nabla_run: $(NABLA_RUN)
	install -m 775 -D $(NABLA_RUN) $@

# should print "Hello, Rump!!" (among a lot of other stuff)
.PHONY: test-node
test-node: solo5 rumprun-packages/nodejs/node.seccomp
	# this test_hello/ukvm-bin does not use any device modules
	solo5/tests/test_hello/ukvm-bin build/node.nablet

.PHONY: clean distclean clean_solo5 clean_rump clean_node clean_node clean_nabla_run
clean:
	rm -rf build/

distclean: clean_solo5 clean_rump

clean_solo5:
	make clean -C solo5

clean_rump:
	rm -f $(RUMP_SOLO5_SECCOMP) $(RUMP_LIBC)
	make clean -C rumprun

clean_node:
	make clean -C rumprun-packages/nodejs

clean_node:
	make clean -C nabla-run
