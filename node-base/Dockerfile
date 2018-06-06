FROM scratch

ADD node.nablet /node.nablet

ENTRYPOINT ["/nabla_run", "--docker", "--ukvm", "/ukvm-bin", "--unikernel", "/node.nablet"]
