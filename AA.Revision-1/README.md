# Revision

## :zero: Keys

```
ssh-keygen -t rsa -b 4096
```



- [ ] Prive

* fichier généré

```
~/.ssh/id_rsa
```

* renommer le fichier 

```
mv ~/.ssh/id_rsa ~/.ssh/b300098957
```

- [ ] Public

* fichier généré

```
~/.ssh/id_rsa.pub
```
* renommer le fichier 

```
mv ~/.ssh/id_rsa.pub ~/.ssh/b300098957.pub
```

- [ ] Configurer l'agent

* demarrer l'agent (portefeuille de clé)

```
eval $(ssh-agent)
```

* rajouter la clè

```
ssh-add ~/.ssh/b300098957
```




- [ ] Se connecter au serveur sans mot de passe

* avec l'identité

```
ssh -i ~/.ssh/b300098957 ubuntu@locahost.gasy.africa
```

* sans mot de passe

```
ssh ubuntu@localhost.gasy.africa
```

* Mettre clé publique sur le serveur

```
~/.ssh/authorized_keys
```





- [ ] Aller sur sa machine


* ajouter la clé

```
ssh-add ~/.ssh/b300098957
```

* utiliser le fichier de configuration

`localhost.gasy.africa`

* ~/.ssh/config

```
Host 10.13.237.244
  HostName 10.13.237.244
  User ubuntu
  Port 22
  IdentityFile ~/.ssh/b300098957
```


## :one: GIT


[GIT Tutoriel](https://github.com/CollegeBoreal/Tutoriels/tree/main/0.GIT)

* Chercher le cours

```
mkdir Developer
```

* Cloner le cours

```
git clone git@github.com:CollegeBoreal/INF1100-201-23H-02.git
```

* Aller dans le cours

```
cd INF1100-201-23H-02
```

* Créer un fichier avec son :id: 

```
touch 300098957.md
```


