# :two: Compose

#### [:tada: Participation](.scripts/Participation.md)


## :gear: VM

- [ ] Se connecter à [Azure](https://github.com/CollegeBoreal/Tutoriels/tree/main/2.MicroServices/4.Cloud/2.Public/2.Azure)

- [ ] Créer les scripts 'terraform' en utilisant [boot](boot)

* crée un répertoire avec ton :id:

```
mkdir <ton ID>
```

* copie le répertoire `boot` dans ton répertoire :id:

```
cp -r boot <ton ID>
```

* aller dans le répertoire `boot` de son `:id:`

```
cd <ton ID>/boot
```

* éditer le code source `terraform` avec Visual Studio Code 

```
code .
```

* dans `main.tf` changer tous les noms comportants CB-AZ-300000000 avec CB-AZ-:id: 

- [ ] Créer sa machine virtuelle

* initialiser les modules et fournisseurs

```
terraform init
```

* créer la machine virtuelle

```
terraform apply
```

## :a: Docker Context

https://blog.mikesir87.io/2019/08/using-ssh-connections-in-docker-contexts/

- [ ] Set the `SSH` agent and key 

- [ ] Create the context

```
docker context create machine-CB-AZ-<ton ID> --docker "host=ssh://terraform@<ton IP>"
```

- [ ] Use the context 

```
docker context use machine-CB-AZ-<ton ID>
```

## :b: docker-compose

https://livebook.manning.com/book/docker-in-action-second-edition/chapter-11/81

- [ ] Dans votre repertoire :id:

    Creer un fichier `README.md` ou vous mettrez votre nom de domaine i.e. `wordpress.<nomd de domaine>`

- [ ] Chercher un fichier `docker-compose.yml` pour illustrer plusieurs containeurs sur un seul `noeud`.


Penser à `wordpress`, bien sûr vous pouvez utiliser cet example

https://docs.docker.com/samples/wordpress/
``
ou chercher avec Google en tapant dans la recherche

```
docker-compose yml example bitnami
```

- [ ] Copier le fichier `yaml` dans votre repertoire  

- [ ] Lancer la commande,

```
docker-compose up --detach
```



Bonne chance

![image](images/docker-compose.png)

