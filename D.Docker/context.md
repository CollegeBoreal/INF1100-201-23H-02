# :control_knobs: Docker Context

## :whale: Commandes pour "entrer" dans les trois dockers

- [ ] Créer un [docker context](https://docs.docker.com/engine/context/working-with-contexts/)

   :bulb: :id: est votre numéro d'étudiant

`docker context create context-`:id:` --docker "host=ssh://ubuntu@10.13.237.X"`


:warning: S'assurer que la clé privée `SSH` est visible par l'agent `ssh-agent` avec la commande `ssh-add ~/.ssh/<ma cle privee>`

- [ ] Lister les contextes

```
docker context ls
```

- [ ] Selectionner un contexte 

`docker context use context-:id:`

- [ ] Vérifier que le contexte est sélectionné (repérer l':star:)

```
NAME                         DESCRIPTION                               DOCKER ENDPOINT                                     KUBERNETES ENDPOINT                                    ORCHESTRATOR
...
context-300098957    *                                          ssh://ubuntu@10.13.237.254                                            
```

