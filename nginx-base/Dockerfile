FROM scratch

COPY rootfs/etc /etc
COPY nginx.nabla /nginx.nabla
COPY data /data

ENTRYPOINT ["/nginx.nabla"]
