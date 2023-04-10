# :wheel_of_dharma: Kubernetes

`ORCHESTRER DES APPLICATIONS`

#### [:tada: Participation](.scripts/Participation.md)

## :a: Déploiements

:round_pushpin: En mode impératif

Créer un déploiement appellé `apache` qui utilise l'image `httpd:2.4.54` et contient 3 répliques (en: replicas). Après la création du déploiement, augmenter (en: scale) le déploiement de cinq répliques (en: replicas) et changer l'image en `httpd:alpine`.

:bulb: `alias k=kubectl` à mettre dans votre fichier `~/.bash_aliases` ou `~/.zshrc` dépendemment de votre `shell`

- [ ] Créer un déploiement

```
k create deploy apache --image=apache:2.4.54 --replicas=3
```
> deployment.apps/apache created

- [ ] Vérifier le déploiement

:x: Les conteneurs `READY(0/3)` ne sont pas créés

```
k get deploy 
```
> Outputs :
<pre>
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
apache   0/3     3            0           25s
</pre>

- [ ] Vérifier  les logs

:x: image can't be pulled - L'image n'existe pas

```
k logs deploy/apache
```
> Retourne :
<pre>
Found 3 pods, using pod/apache-7bddcd464d-lgj5x
Error from server (BadRequest): container "apache" in pod "apache-7bddcd464d-lgj5x" is waiting to start: image can't be pulled
</pre>


- [ ] Changer l'image d'origine

* changer le nom de l'image à `httpd:alpine`

```
k set image deploy apache apache=httpd:alpine
```

* Vérifier le déploiement

:x: Les conteneurs `READY(0/3)` ne sont pas créés

```
k get deploy 
```
> Retourne :
<pre> 
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
apache   3/3     3            3           4m4s
</pre>


- [ ] Augmenter les répliques

```
k scale deploy apache --replicas=5
```

- [ ] Vérifier le nombre de `pods`

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


:round_pushpin: En mode déclaratif

:bulb: Cloner le cours sur votre serveur, dans le répertoire `4.Kubernetes` créer un répertoire avec votre :id:

```
k create deploy nginx --image nginx --dry-run=client -o yaml > deploy.yaml
```

```
k create --filename deploy.yaml
```
