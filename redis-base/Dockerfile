FROM scratch

ADD redis-server.nablet /redis-server.nablet

ADD redisaof.conf /data/conf/redisaof.conf
ADD redis.conf /data/conf/redis.conf

ENTRYPOINT ["/nabla_run", "--docker", "--ukvm", "/ukvm-bin", "--unikernel", "/redis-server.nablet"]
