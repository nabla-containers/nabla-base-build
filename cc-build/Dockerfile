FROM ubuntu:18.04

RUN apt-get update 
RUN apt-get install -y build-essential git

ADD rumprun-solo5 /root/nabla-base-build/rumprun

ENV PATH="/root/nabla-base-build/rumprun/rumprun-solo5/bin:${PATH}"
ENV CC="x86_64-rumprun-netbsd-gcc" 


