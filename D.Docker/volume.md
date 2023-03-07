# Docker Volume

:bulb: Storage in Docker

## :a: There are 2 types of storage in docker:

- [ ] Ephemeral Storage

Ephemeral storage is the volatile temporary storage attached to the docker container which is only present during the running life of the instance. In the case that the container is stopped or terminated or underlying hardware faces an issue, any data stored on ephemeral storage would be lost.

- [ ] Persistent Storage

Persistent storage is any data storage device that retains data after power to that device is shut off. It is also sometimes referred to as nonvolatile storage.

## :b: How to attach this persistent storage to a Docker container?

There are 2 ways:

1. Attach a `base directory` data to the docker container

```
docker container run --interactive --tty --detach --publish 85:80 \
   --volume /Users/dev/test/data:/usr/local/apache2/htdocs httpd
```

2. Docker volumes

- [ ] Create the volume 

```
docker volume create --name wordpress_data
```

- [ ] Use the volume

```
docker container run --interactive --tty --detach --publish 85:80 \
   --volume wordpress_data:/usr/local/apache2/htdocs httpd
```

## :ab: Some Commands:

1. To list all volumes:

```
docker volume ls
```

2. Delete the volume

```
docker volume rm volume_id
```

3. To delete all volumes created in the system forcefully

```
docker volume rm $(docker volume ls --quiet ) --force
```
