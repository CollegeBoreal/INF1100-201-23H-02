# 2 Keys

## :one: Authoriser l'acces à sa machine au professeur

* Connectez vous à votre machine avec `git bash` ou `putty`

```
$ ssh monID@monAdresseIP
```

* Ouvrir le fichier d'authorisation de clés publiques suivant avec Nano 

:warning: si le répertoire `~/.ssh` n'existe pas, veuillez le créer

```
$ nano ~/.ssh/authorized_keys
```

* copier la clé publique ci-dessous dans une nouvelle ligne 

(attention copier la clé tel quel sans espace ou autre charactere, i.e. la clé est longue)

```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD2pLhMqFGKffSdYvNCMAyM7598oBY+m/3q5AMXmb7IE6vq42+yGzqEUzZu9WrFckFD4Hq52rIU5DeOvi83DCF3uroXjNTEtCKdi+tY7cV18bHmsDsBHMqTnpuvroofgFWA0Pi++b2kGW2I5eyy1Qjv5rOp7y11Xe6XeZFEz7qQO1/xNiBMJEruG9Xldgooe4hkaOF39qnbqD4ui3LxYaTUTEulstw4wN70dSB8Zu9YQP7A7KU2zIEwJ1aw8whfO1CAM/AVvoDyqMtV8VXoaZSHOBgluMtinQfyyt473S2ZZeJlnmhK0F1gdOhO4SVZNRMj96m30ryYkYBFWvvLRP5N b300098957@ramena
```

##  :two: Participation

[:tada: Participation](.scripts/Participation.md)

## :three: [keygen](https://www.ssh.com/academy/ssh/keygen) Gestion des clés publique et privée

avec ssh-`keygen`

```
ssh-keygen -t rsa -b 4096
```

* Renommer la clé privé pour la sauvegarder (par défaut le fichier de la clé privée se nomme `~/.ssh/id_rsa`)

:bulb: Remplacer b300098957 par votre propre :id: Boréal i.e. b000000000 (vos 9 chiffres)

```
mv ~/.ssh/id_rsa ~/.ssh/b300098957
```

* Renommer la clé publique (par défaut le fichier de la clé publique se nomme `~/.ssh/id_rsa.pub`)

```
mv ~/.ssh/id_rsa.pub ~/.ssh/b300098957.pub
```

* Copier sa clé publique vers le serveur

avec ssh-`copy-id`

:bulb: Remplacer b300098957 par votre propre :id: Boréal i.e. b000000000 (vos 9 chiffres) et `prof@10.13.237.253` par vos propres informations

```
ssh-copy-id -i ~/.ssh/b300098957 prof@10.13.237.253
```

- [ ] Accéder à la machine

:piavec l'identifiant en tapant ssh `-i`

```
ssh -i ~/.ssh/b300098957 prof@10.13.237.253
```

- [ ] Accéder à la machine sans spécifier l'identifiant

:warning: sous `git-bash` uniquement, avec l'agent ssh `ssh-agent`

```
eval $(ssh-agent)
```

* ajouter la clé privée à la liste gérée par l'agent SSH

```
ssh-add ~/.ssh/b300098957
```

* lister les clés gérées par l'agent SSH

```
ssh-add -l
```

# References

- [ ] [What is PKI and How Does it Work?](https://www.keyfactor.com/resources/what-is-pki/)
