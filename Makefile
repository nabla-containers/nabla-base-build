
.PHONY: nginx-base node-base python3-base redis-base
all: nginx-base node-base python3-base redis-base

nginx-base:
	make -C $@
node-base:
	make -C $@
python3-base:
	make -C $@
redis-base:
	make -C $@

.PHONY: submodules
submodules:
	git submodule update --init

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

build/node.nabla: rumprun-packages/nodejs/node.seccomp
	install -m 775 -D $< $@

build/redis-server.nabla: rumprun-packages/redis/bin/redis-server.seccomp
	install -m 775 -D $< $@

build/python3.nabla: rumprun-packages/python3/python.seccomp
	install -m 775 -D $< $@

build/nginx.nabla: rumprun-packages/nginx/bin/nginx.seccomp
	install -m 775 -D $< $@

.PHONY: clean distclean clean_solo5 clean_rump 
clean:
	rm -rf build/
	make clean -C node-base
	make clean -C nginx-base
	make clean -C redis-base
	make clean -C python3-base

distclean: clean_solo5 clean_rump
	make distclean -C rumprun-packages/nodejs
	make clean -C rumprun-packages/redis
	make distclean -C rumprun-packages/nginx
	make distclean -C rumprun-packages/python3

clean_solo5:
	make clean -C solo5

clean_rump:
	rm -f $(RUMP_SOLO5_SECCOMP) $(RUMP_LIBC)
	make clean -C rumprun
