FROM python:3.5.2-alpine
RUN apk update && apk add iproute2 git

# The first stage is just for the second one to get /usr/loca/lib/python in it,
# which is needed by python.

FROM scratch
ADD python3.nablet /python3.nablet
COPY rootfs /
COPY --from=0 /usr/local/lib /usr/local/lib
ENTRYPOINT ["/nabla_run", "--docker", "--ukvm", "/ukvm-bin", "--unikernel", "/python3.nablet", "--volume", "/usr/local:/usr/local"]
