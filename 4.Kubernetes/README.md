# :wheel_of_dharma: Kubernetes

`ORCHESTRER DES APPLICATIONS`

## :a: Déploiement

:round_pushpin: En mode impératif

Créer un déploiement appellé `apache` qui utilise l'image `httpd:2.4.54` et contient 3 répliques (en: replicas). Après la création du déploiement, augmenter (en: scale) le déploiementt de cinq répliques (en: replicas) et changer l'image en `httpd:alpine`.

:bulb: `alias k=kubectl`

```
k create deploy apache --image httpd:2.4.54 –-replicas 3
```

```
k scale deploy apache -–replicas 5
```

