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

- [ ] Push image to docker hub or ghcr.io 

```
docker image push ghcr.io/collegeboreal/aide:1.0.8   
```
> Outputs :
<pre>
The push refers to repository [ghcr.io/uontario/aide]
bf679b93d651: Layer already exists 
c6f829b9471d: Layer already exists 
1d886466c455: Layer already exists 
2348e9726bab: Layer already exists 
a565521a6b61: Layer already exists 
fc9a7040ee93: Layer already exists 
c700d3f5f15b: Layer already exists 
e75b8fc6a0d5: Layer already exists 
8e012198eea1: Layer already exists 
1.0.8: digest: sha256:03a528b0fa454d159afa2ddea2ce7e6b3fae4f8af61cbda6c29ada350d2aa7e5 size: 2200
</pre>
