FROM scratch

COPY redis-server.nabla /redis-server.nabla
COPY redisaof.conf /data/conf/redisaof.conf
COPY redis.conf /data/conf/redis.conf

ENTRYPOINT ["/redis-server.nabla"]
