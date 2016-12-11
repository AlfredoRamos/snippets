### Info

A minimal Arch Linux Docker image

### Dependencies

- Docker Compose [[docs](https://docs.docker.com/compose/install/)]

### Usage

Note: `docker.service` must be already running [[wiki](https://wiki.archlinux.org/index.php/Docker)]

**Build and start**

```shell
docker-compose up --build --remove-orphans
```

**Run**

```shell
docker run -it --rm alfredo-ramos/arch-linux /bin/bash
```
