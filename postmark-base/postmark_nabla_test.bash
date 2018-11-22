#!/bin/bash

# runnc can't run programs that write to the disk yet because it
# places files in a temporary filesystem.  As a result, postmark (this
# fs benchmark) will not work using runnc.  This script is a
# workaround to directly run the process (not as a Docker container).

# Usage: bash ./postmark_nabla_test.bash ./benchmark.pmrc
PMRC=$1

### If you don't have tap100, do this:
# sudo ip tuntap add tap100 mode tap
# sudo ip addr add 10.0.0.1/24 dev tap100
# sudo ip link set dev tap100 up

mkdir /tmp/data
cp $PMRC /tmp/data/benchmark.pmrc

### If you don't have genlfs, get it from https://github.com/ricarkol/genlfs
genlfs /tmp/data/ data.lfs

### If you don't have nabla-run, get it from https://github.com/nabla-containers/runnc
nabla-run --disk=data.lfs --net=tap100 postmark.nabla '{"cmdline":"bin/postmark.nabla /data/benchmark.pmrc","net":{"if":"ukvmif0","cloner":"True","type":"inet","method":"static","addr":"10.0.0.2","mask":"16"},"blk":{"source":"etfs","path":"/dev/ld0a","fstype":"blk","mountpoint":"/data"}}'
