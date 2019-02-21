#!/usr/bin/env bats
## Copyright (c) 2018, IBM
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

load helpers

function setup() {
	cd ${TOPLEVEL}/tests/integration
	sudo ip tuntap add tap_nabla_test mode tap
	sudo ip addr add 21.0.0.1/24 dev tap_nabla_test
	sudo ip link set dev tap_nabla_test up
}

function teardown() {
	sudo ip link delete tap_nabla_test
}

function nabla_run() {
	run ${TOPLEVEL}/rumprun/solo5/tenders/spt/solo5-spt --net=tap_nabla_test "$@"

	echo "nabla-run $@ (status=$status):" >&2
	echo "$output" >&2
}

@test "test raw node version" {
	nabla_run ${TOPLEVEL}/node-base/node.nabla -- '{"cmdline":"node --version"}'
	[[ "$output" == *"v4.3.0"* ]]
	[ "$status" -eq 0 ]
}


@test "test raw node (hello)" {
	nabla_run ${TOPLEVEL}/node-base/node.nabla
	# node with no args prints "Hello, Rump!!"
	[[ "$output" == *"Hello, Rump!!"* ]]
	[ "$status" -eq 0 ]
}

@test "test raw python version" {
	nabla_run ${TOPLEVEL}/python3-base/python3.nabla -- '{"cmdline":"python --version"}'
	[[ "$output" == *"Python 3.5.2"* ]]
	[ "$status" -eq 0 ]
}

@test "test raw redis version" {
	nabla_run ${TOPLEVEL}/redis-base/redis.nabla -- '{"cmdline":"redis --version"}'
	[[ "$output" == *"Redis server v=3.0.6"* ]]
	[ "$status" -eq 0 ]
}

@test "test raw nginx version" {
	nabla_run ${TOPLEVEL}/nginx-base/nginx.nabla -- '{"cmdline":"nginx -v"}'
	[[ "$output" == *"nginx version: nginx/1.8.0"* ]]
	[ "$status" -eq 0 ]
}

@test "test raw go hello" {
	nabla_run ${TOPLEVEL}/tests/gotest/goapp.nabla
	[[ "$output" == *"Hello, Rumprun.  This is Go."* ]]
	[ "$status" -eq 0 ]
}
