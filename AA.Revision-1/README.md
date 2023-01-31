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

* sans mot de passe

```
ssh ubuntu@localhost.gasy.africa
```

* Mettre clé publique sur le serveur

```
~/.ssh/authorized_keys
```





- [ ] Aller sur sa machine

`localhost.gasy.africa`

## :one: GIT
