FROM scratch

ADD nginx.nablet /nginx.nablet

COPY data /data

ENTRYPOINT ["/nabla_run", "--docker", "--ukvm", "/ukvm-bin", "--unikernel", "/nginx.nablet"]
