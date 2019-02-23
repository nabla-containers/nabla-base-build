SHELL := /bin/bash
export TOP=$(abspath ../..)
GOBASE=$(TOP)/go-base
RUMPRUN=$(TOP)/rumprun

nabla: test_curl.nabla

.PHONY: setup
setup:
	sudo bash setup-tests.sh

test_curl: test_curl.c
	source $(RUMPRUN)/obj/config-PATH.sh &&	x86_64-rumprun-netbsd-gcc -g -o $@ $<

test_curl.nabla: test_curl
	source $(RUMPRUN)/obj/config-PATH.sh &&	rumprun-bake solo5_spt $@ $<

run_spt: test_curl.nabla
	$(SOLO5SRC)/tenders/spt/solo5-spt --net=tap100 $< '{"cmdline":"$< 10.0.0.4","net":{"if":"ukvmif0","cloner":"True","type":"inet","method":"static","addr":"10.0.0.2","mask":"16"}}'

.PHONY: clean
clean:
	rm -f test_curl test_curl.nabla
