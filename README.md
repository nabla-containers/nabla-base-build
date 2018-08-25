
This repository builds base Docker images for Rumprun-based nabla
containers.  So far we provide the following:

    nginx-base
    node-base
    python3-base
    redis-base
    hello-base

### Building the bases

First fetch the submodules (solo5, rumprun, and rumprun-packages):
```
git submodule update --init --recursive
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

To see how to use these bases in practice for your own applications,
see the
[nabla-containers/nabla-demo-apps](https://github.com/nabla-containers/nabla-demo-apps)
repository.
