FROM scratch

ADD node.nablet /node.nablet
ADD ukvm-bin /ukvm-bin
ADD nabla_run /nabla_run

ENTRYPOINT ["/nabla_run", "--docker", "--ukvm", "/ukvm-bin", "--unikernel", "/node.nablet"]
