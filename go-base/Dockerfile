FROM ubuntu:16.04

# rumprun can only be built with gcc-6
# XXX: Not only that, this version has to match whatever
# gcc was used to build rumprun in the host.
RUN apt-get update && \
	apt-get install git build-essential software-properties-common -y && \
	add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
	apt-get update && \
	apt-get install gcc-snapshot -y && \
	apt-get update && \
	apt-get install gcc-6 g++-6 -y && \
	update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-6 && \
	apt-get install gcc-4.8 g++-4.8 -y && \
	update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.8

RUN mkdir /gopath
RUN mkdir /goapp

# XXX: this is pretty inconvenient. Turns out that rumprun
# needs to be at exactly the same place where it was built.
# (unless I'm missing something).
ARG host_rumproot
COPY rumprun-solo5 ${host_rumproot}
COPY gorump /gorump

COPY gomaincaller.go /goapp
COPY _gorump_main.c /goapp
COPY Makefile.goapp /goapp

ENV PATH="${host_rumproot}/rumprun-solo5/bin:${PATH}"
ENV CC="x86_64-rumprun-netbsd-gcc" 
ENV GOROOT="/gorump"
ENV GOPATH="/gopath"
ENV GOTOOLDIR="/gorump/pkg/tool/linux_amd64"
ENV CGO_ENABLED="1" 
ENV GOOS="rumprun" 
ENV PATH="/gorump/bin:${PATH}"
