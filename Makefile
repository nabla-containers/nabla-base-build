default: build

.PHONY: submodules
submodules:
	git submodule update --init

build: build/node.nablet build/redis-server.nablet build/python3.nablet build/nginx.nablet

test: test-node

SOLO5_OBJ=solo5/kernel/ukvm/solo5.o

solo5: $(SOLO5_OBJ)

$(SOLO5_OBJ):
	UKVM_STATIC=yes make -C solo5 ukvm

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

rumprun-packages/redis/bin/redis-server.seccomp: $(RUMP_SOLO5_SECCOMP) $(RUMP_LIBC) rumprun-packages/config.mk
	source rumprun/obj/config-PATH.sh && make -C rumprun-packages/redis bin/redis-server.seccomp

rumprun-packages/python3/python.seccomp: $(RUMP_SOLO5_SECCOMP) $(RUMP_LIBC) rumprun-packages/config.mk
	source rumprun/obj/config-PATH.sh && make -C rumprun-packages/python3 python.seccomp

rumprun-packages/nginx/bin/nginx.seccomp: $(RUMP_SOLO5_SECCOMP) $(RUMP_LIBC) rumprun-packages/config.mk
	source rumprun/obj/config-PATH.sh && make -C rumprun-packages/nginx all
	source rumprun/obj/config-PATH.sh && make -C rumprun-packages/nginx bin/nginx.seccomp

build/node.nablet: rumprun-packages/nodejs/node.seccomp
	install -m 775 -D $< $@

build/redis-server.nablet: rumprun-packages/redis/bin/redis-server.seccomp
	install -m 775 -D $< $@

build/python3.nablet: rumprun-packages/python3/python.seccomp
	install -m 775 -D $< $@

build/nginx.nablet: rumprun-packages/nginx/bin/nginx.seccomp
	install -m 775 -D $< $@

# should print "Hello, Rump!!" (among a lot of other stuff)
.PHONY: test-node
test-node: build
	sudo build/nabla_run -tap tap007 -ukvm build/ukvm-bin -unikernel build/node.nablet build/python3.nablet

.PHONY: clean distclean clean_solo5 clean_rump clean_node clean_node
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

