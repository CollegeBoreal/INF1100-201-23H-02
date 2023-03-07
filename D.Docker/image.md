# Docker Image -- basic commands:


## :bulb: Dockerfile

- [ ] Quels sont les instructions pour créer sa propre image?

| Instructions |  Commentaires                                                                                                |
|--------------|--------------------------------------------------------------------------------------------------------------|
| `#`          | faire un commentaire                                                                                         |
| `FROM`       | Donner une image                                                                                             |
| `LABEL`      | Donner de l'information (i.e. `maintener=`)                                                                  |
| `ENV`        | permet de passer des variables d'environnements. Note: utiliser le paramêtre `--env` à la ligne de commande  |
| `WORKDIR`    | Comme `pwd` en Unix, indique le répertoire de travail ou courant                                             |
| `ADD`        | Ajoute des fichiers (compréssés) ou des répertoires à l'image                                                |
| `COPY`       | Ajoute des fichiers à l'image                                                                                |
| `RUN`        | Éxécute les scripts ou installe des librairies ( `apt-get` ou `pip` ) dans l'image                           |
| `ENTRYPOINT` | Par défaut éxécute à la fin de l'installation `["/bin/sh"]`. On peut l'`override` (outrepasser ou remplacer) |
| `CMD`        | Permet de rajouter des parametres à la commande `ENTRYPOINT` - de type tableaux [ "param1", "parma2"]        |

- [ ] Un example de `Dockerfile`

```Dockerfile
FROM debian:9.5-slim

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
```

- [ ] Construire l'image

`docker image build --tag b`🆔`:1.0 .`

- [ ] Afficher l'historique des couches

`docker image history b`🆔`:1.0`
> Outputs :
<pre>
IMAGE          CREATED      CREATED BY                                      SIZE      COMMENT
74f2314a03de   6 days ago   /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B        
<missing>      6 days ago   /bin/sh -c #(nop) ADD file:fb4c8244f4468cdd3…   77.8MB    
<missing>      6 days ago   /bin/sh -c #(nop)  LABEL org.opencontainers.…   0B        
<missing>      6 days ago   /bin/sh -c #(nop)  LABEL org.opencontainers.…   0B        
<missing>      6 days ago   /bin/sh -c #(nop)  ARG LAUNCHPAD_BUILD_ARCH     0B        
<missing>      6 days ago   /bin/sh -c #(nop)  ARG RELEASE                  0B        
</pre>

## :a: Images

- [ ] :one::zero: List all images present in the system

```
docker image ls
```

- [ ] Pull an image from [Docker Hub](https://hub.docker.com/_/ubuntu/)

```
docker image pull ubuntu
```

- [ ] Connecting to Docker Hub

```
docker login
```
> Outputs :
<pre>
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: 
</pre>

- [ ] Push image to `docker hub` 

```
docker image push collegeboreal/kuron
```
> Outputs :
<pre>
The push refers to repository [docker.io/collegeboreal/kuron]
e349017e9786: Pushed 
ab90d83fa34a: Mounted from library/node 
8ee318e54723: Mounted from library/node 
e6695624484e: Mounted from library/node 
da59b99bbd3b: Mounted from library/node 
5616a6292c16: Mounted from library/node 
f3ed6cb59ab0: Mounted from library/node 
654f45ecb7e3: Mounted from library/node 
2c40c66f7667: Mounted from library/node 
latest: digest: sha256:0b4b251265d6dae45e070b9467e22796c38a98b16f88a3c642f860a6cc355b11 size: 2213
</pre>
