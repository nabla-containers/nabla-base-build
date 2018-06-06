FROM scratch

ADD redis-server.nablet /redis-server.nablet

ADD redisaof.conf /data/conf/redisaof.conf
ADD redis.conf /data/conf/redis.conf

ENTRYPOINT ["/redis-server.nablet"]
