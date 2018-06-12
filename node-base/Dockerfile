FROM scratch

# XXX: This is a temporary horrible hack which should disappear as soon as we
# fix a rumprun issue we introduced by trying to mount the root which is over
# writing rumprun's /dev devices (like random).
COPY dev /dev

COPY node.nabla /node.nabla

ENTRYPOINT ["/node.nabla"]
