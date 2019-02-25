SHELL := /bin/bash
export TOP=$(abspath ../..)
GOBASE=$(TOP)/go-base
RUMPRUN=$(TOP)/rumprun

nabla: goapp.nabla

goapp.a: $(wildcard *.go)
	source $(RUMPRUN)/obj/config-PATH.sh && unset GOROOT && CC=x86_64-rumprun-netbsd-gcc CGO_ENABLED=1 GOOS=rumprun $(GOBASE)/go build -buildmode=c-archive -v -a -x -o goapp.a

goapp.pseudo: goapp.a
	source $(RUMPRUN)/obj/config-PATH.sh &&	RUMPRUN_STUBLINK=succeed x86_64-rumprun-netbsd-gcc -g -o goapp.pseudo _gorump_main.c goapp.a

goapp.nabla: goapp.pseudo
	source $(RUMPRUN)/obj/config-PATH.sh &&	rumprun-bake solo5_spt $@ $<

run_spt: goapp.nabla
	$(SOLO5SRC)/tenders/spt/solo5-spt --net=tap100 $< '{"cmdline":"$<"}'

%.bin: %.pseudo
	(source $(RUMPRUN)/obj/config && $(RUMPRUN_BAKE) hw_virtio $@ $<)

clean:
	rm -f goapp.a goapp.h goapp.nabla goapp.pseudo 
