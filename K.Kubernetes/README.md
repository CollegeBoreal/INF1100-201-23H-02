# :wheel_of_dharma: Kubernetes


[Borg: The Predecessor to Kubernetes](https://kubernetes.io/blog/2015/04/borg-predecessor-to-kubernetes)

Google exécute des charges de travail conteneurisées (containerized workloads) en production depuis plus d’une décennie.  Qu’il s’agisse d’emplois de service tels que les serveurs Web frontaux et les serveurs avec état (base de données), de systèmes d’infrastructure tels que `Bigtable` et `Spanner` ou de structures par lots telles que `MapReduce` et `Millwheel`, pratiquement tout chez Google fonctionne sous forme de __conteneur__. Aujourd’hui, nous avons dévoilé Borg, le système interne de gestion de cluster orienté conteneurs de Google, dont on parle depuis longtemps, en publiant des détails lors de la conférence académique sur les systèmes informatiques [Eurosys](http://eurosys2015.labri.fr/). Vous pouvez trouver le document [ici](https://research.google.com/pubs/pub43438.html).

![image](images/full-kubernetes-model-architecture.png)


:gear: :ice_cube: Kube Config - Configuration de grappes

<img src=images/Lens_Config.png width='' height='' > </img>

- [ ] Identifier les grappes

```
k config get-clusters
```
```yaml
NAME
kind-k8s
kubernetes
```

- [ ] Identifier les contextes (:star: signifie que la grappe `kind-k8s` est sélectionée)

```
k config get-contexts
```
```yaml
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
*         kind-k8s                      kind-k8s     kind-k8s           
          kubernetes-admin@kubernetes   kubernetes   kubernetes-admin   
```

- [ ] Changer de contexte

```
k config use-context kubernetes-admin@kubernetes
```
> Switched to context "kubernetes-admin@kubernetes".



- [ ] regrouper plusieurs configurations dans un seul fichier `~/.kube/config`

:bulb: La variable d'environnement `KUBECONFIG` permet de regrouper les grappes ensemble

```
KUBECONFIG=~/.kube/config~kind:~/.kube/config~orion \
    kubectl config view --flatten > ~/.kube/config
```


:knot: Noeuds

<img src=images/Lens_Nodes.png width='' height='' > </img>

```
 k get no
```
```yaml
NAME         STATUS   ROLES           AGE   VERSION
bellatrix    Ready    <none>          43h   v1.26.3
betelgeuse   Ready    control-plane   43h   v1.26.3
```

:factory: Charge de travail (Workloads)


<img src=images/Lens_Workloads.png width='' height='' > </img>

<img src=images/Lens_Kubesphere_Workloads.png width='' height='' > </img>
