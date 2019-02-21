SHELL := /bin/bash
export TOP=$(abspath ../..)
GOBASE=$(TOP)/go-base
RUMPRUN=$(TOP)/rumprun

spt: goapp.spt

goapp.a: $(wildcard *.go)
	source $(RUMPRUN)/obj/config-PATH.sh && unset GOROOT && CC=x86_64-rumprun-netbsd-gcc CGO_ENABLED=1 GOOS=rumprun $(GOBASE)/go build -buildmode=c-archive -v -a -x -o goapp.a

goapp.pseudo: goapp.a
	source $(RUMPRUN)/obj/config-PATH.sh &&	RUMPRUN_STUBLINK=succeed x86_64-rumprun-netbsd-gcc -g -o goapp.pseudo _gorump_main.c goapp.a

goapp.spt: goapp.pseudo
	source $(RUMPRUN)/obj/config-PATH.sh &&	rumprun-bake solo5_spt goapp.spt goapp.pseudo
	mv goapp.spt goapp.nabla

%.bin: %.pseudo
	source $(RUMPRUN)/obj/config-PATH.sh && rumprun-bake hw_virtio $@ $<

clean:
	rm -f goapp.a goapp.h goapp.spt goapp.pseudo 
