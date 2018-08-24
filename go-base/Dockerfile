FROM ubuntu:16.04

RUN apt-get update 
RUN apt-get install -y build-essential git
RUN mkdir /gopath
RUN mkdir /goapp

ADD rumprun-solo5 /root/unikernels/nabla-base-build/rumprun
ADD gorump /gorump

COPY gomaincaller.go /goapp
COPY _gorump_main.c /goapp
COPY Makefile.goapp /goapp

ENV PATH="/root/unikernels/nabla-base-build/rumprun/rumprun-solo5/bin:${PATH}"
ENV CC="x86_64-rumprun-netbsd-gcc" 
ENV GOROOT="/gorump"
ENV GOPATH="/gopath"
ENV GOTOOLDIR="/gorump/pkg/tool/linux_amd64"
ENV CGO_ENABLED="1" 
ENV GOOS="rumprun" 
ENV PATH="/gorump/bin:${PATH}"


