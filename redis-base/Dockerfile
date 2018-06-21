FROM scratch

COPY redis.nabla /redis.nabla
COPY redisaof.conf /data/conf/redisaof.conf
COPY redis.conf /data/conf/redis.conf

ENTRYPOINT ["/redis.nabla"]
