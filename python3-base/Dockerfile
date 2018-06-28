FROM python:3.5.2-alpine

# The first stage is just for the second one to get /usr/local/lib/python in it,
# which is needed by python.

FROM scratch
COPY python3.nabla /python3.nabla

COPY rootfs /
COPY --from=0 /usr/local/lib /usr/local/lib
ENV PYTHONHOME=/usr/local
ENTRYPOINT ["/python3.nabla"]
