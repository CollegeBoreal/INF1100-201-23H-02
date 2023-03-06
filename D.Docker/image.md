# Docker Image -- basic commands:


## :bulb: Dockerfile

Quels sont les instructions pour créer sa propre image?

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


## :a: Images

- [ ] :one::zero: List all images present in the system

```
docker image ls
```

