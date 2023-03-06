# Docker Container basic commands:


## :a: Container

- [ ] :one: Start a new container & it will take you inside the docker terminal

```
docker container run --interactive --tty ubuntu
```
>root@9e4f5456f:/#

- [ ] :two: To run a container in detach mode (Not give terminal instantly) 

```
docker container run --interactive --tty --detach ubuntu
```
> 9e4f5456ff671077d0b59bdfb829aae4f5456ff671aa077d0b59bdfb82

:bulb: Note the `container_id` - the big number

- [ ] :three: List all containers running

```
docker container ls
```

- [ ] :four: List all containers (Stopped + running )

```
docker container ls --all
```

- [ ] :five: To Stop a running container

```
docker container stop container_id
```
> container_id

- [ ] :six: Forcefully Stop a running container

```
docker container kill container_id
```
> container_id

- [ ] :seven: To go inside any docker container.

```
docker container exec --interactive --tty container_id bash
```

- [ ] :eight: To delete a stopped container

```
docker container rm container_id
```
> container_id

- [ ] :nine: To forcefully delete a running container

```
docker container rm --force container_id
```

## :b: Images

- [ ] :one::zero: List all images present in the system

```
docker image ls
```


