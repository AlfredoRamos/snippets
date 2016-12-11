### Info

A minimal Arch Linux Docker image

### Dependencies

- Docker Compose [[info](https://docs.docker.com/compose/install/)]

### Usage

Note: `docker.service` must be already running [[wiki](https://wiki.archlinux.org/index.php/Docker)]

**Build**

```
# docker-compose up --build --remove-orphans
```

**Run** (on your terminal)

```
# docker run -it --rm alfredo-ramos/arch-linux /bin/bash
```
