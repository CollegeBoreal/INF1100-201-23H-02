# :wheel_of_dharma: Kubernetes

`ORCHESTRER DES APPLICATIONS`

## :a: Déploiements

:round_pushpin: En mode impératif

Créer un déploiement appellé `apache` qui utilise l'image `httpd:2.4.54` et contient 3 répliques (en: replicas). Après la création du déploiement, augmenter (en: scale) le déploiement de cinq répliques (en: replicas) et changer l'image en `httpd:alpine`.

:bulb: `alias k=kubectl` à mettre dans votre fichier `~/.bash_aliases`

```
k create deploy apache --image httpd:2.4.54 –-replicas 3
```
> deployment.apps/apache created

```
k get deploy 
```
> Outputs :
<pre>
NAME   READY UP-TO-DATE AVAILABLE AGE 
apache 3/3   3          3         14s
</pre>

```
k scale deploy apache -–replicas 5
```

```
k get po
```
> Outputs
<pre>
NAME                    READY STATUS  RESTARTS AGE 
apache-74f79bcc68-7lzqz 1/1   Running 0        7s 
apache-74f79bcc68-89zwg 1/1   Running 0        33s 
apache-74f79bcc68-v6drf 1/1   Running 0        33s 
apache-74f79bcc68-x7bfw 1/1   Running 0        33s 
apache-74f79bcc68-xdx4b 1/1   Running 0        7s
</pre>
