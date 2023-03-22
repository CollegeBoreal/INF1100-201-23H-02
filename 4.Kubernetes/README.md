# :wheel_of_dharma: Kubernetes

`ORCHESTRER DES APPLICATIONS`

## :a: Déploiements

:round_pushpin: En mode impératif

Créer un déploiement appellé `apache` qui utilise l'image `httpd:2.4.54` et contient 3 répliques (en: replicas). Après la création du déploiement, augmenter (en: scale) le déploiement de cinq répliques (en: replicas) et changer l'image en `httpd:alpine`.

:bulb: `alias k=kubectl`

```
k create deploy apache --image httpd:2.4.54 –-replicas 3
```

```
k scale deploy apache -–replicas 5
```

```
k get deploy 
```
> NAME READY UP-TO-DATE AVAILABLE AGE apache 3/3 3 3 14s

