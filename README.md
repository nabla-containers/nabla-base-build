
This repository builds base Docker images for Rumprun-based nabla
containers.  So far we provide the following:

    nginx-base
    node-base
    python3-base
    redis-base

### Building the bases

First fetch the submodules (solo5, rumprun, and rumprun-packages):
```
make submodules
```

Ensure you have the following prerequisites on your system for
building the bases:
```
apt-get install zlib1g-dev libseccomp-dev
```

Finally build all of the base images:
```
make
```
or just one:
```
make nginx-base
```


### Using the bases

TODO: we will have a repo of examples that use the bases that we can
refer to later.
