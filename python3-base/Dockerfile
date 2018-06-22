FROM python:3.5.2-alpine
RUN apk update && apk add iproute2 git

# The first stage is just for the second one to get /usr/local/lib/python in it,
# which is needed by python.

FROM scratch
COPY python3.nabla /python3.nabla

# XXX: This is a temporary horrible hack which should disappear as soon as we
# fix a rumprun issue we introduced by trying to mount the root which is over
# writing rumprun's /dev devices (like random).
COPY dev /dev

COPY rootfs /
COPY --from=0 /usr/local/lib /usr/local/lib
ENV PYTHONHOME=/usr/local
ENTRYPOINT ["/python3.nabla"]
