FROM scratch

ADD nginx.nablet /nginx.nablet

COPY rootfs /
COPY data /data

ENTRYPOINT ["/nginx.nablet"]
