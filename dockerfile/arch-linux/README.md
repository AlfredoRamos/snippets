### Info

A minimal Arch Linux Docker image

### Dependencies

- Docker engine [[info](https://docs.docker.com/linux/)]

### Usage

Note: `docker.service` must be already running [[wiki](https://wiki.archlinux.org/index.php/Docker)]

**Build**

```
# docker build --force-rm -t arch-linux .
```

**Run** (on your terminal)

```
# docker run -it --rm arch-linux /bin/bash
```
