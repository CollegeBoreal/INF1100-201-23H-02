# :wheel_of_dharma: Kubernetes


[Borg: The Predecessor to Kubernetes](https://kubernetes.io/blog/2015/04/borg-predecessor-to-kubernetes)

Google exécute des charges de travail conteneurisées (containerized workloads) en production depuis plus d’une décennie.  Qu’il s’agisse d’emplois de service tels que les serveurs Web frontaux et les serveurs avec état (base de données), de systèmes d’infrastructure tels que `Bigtable` et `Spanner` ou de structures par lots telles que `MapReduce` et `Millwheel`, pratiquement tout chez Google fonctionne sous forme de __conteneur__. Aujourd’hui, nous avons dévoilé Borg, le système interne de gestion de cluster orienté __conteneurs__ de Google, dont on parle depuis longtemps, en publiant des détails lors de la conférence académique sur les systèmes informatiques [Eurosys](http://eurosys2015.labri.fr/). Vous pouvez trouver le document [ici](https://research.google.com/pubs/pub43438.html).

![image](images/full-kubernetes-model-architecture.png)

Acteurs: 
* Le `DevOps` s'occupe de gérer la grappe et mettre à disposition des utilisateurs les applications
* Les `Utilisateurs` consomment des services à travers les différentes voix de procuration (__proxy__) pour accéder aux applications

:gear: :ice_cube: Kube Config - Configuration de grappes

<img src=images/Lens_Config.png width='' height='' > </img>

- [ ] Utilité du :ice_cube: `Kube Config`

C'est le fichier qui comporte les certificats, clés publiques et privés permettant d'accèder à la grappe

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

Les noeuds sont des serveurs, généralement sous linux, qui constituent l'infrastructure de la grappe :wheel_of_dharma: Kubernetes. Le noeud plan de contrôle (control plane) permet l'administration de la grappe, les noeuds plan de travail (worker node) constituant le plan de données (data plan) sont les chevaux de traits qui font le travail d'éxécuter les conteneurs.

```
 k get no
```
```yaml
NAME         STATUS   ROLES           AGE   VERSION
bellatrix    Ready    <none>          43h   v1.26.3
betelgeuse   Ready    control-plane   43h   v1.26.3
```

k get ns
NAME                              STATUS   AGE
default                           Active   46h
kube-node-lease                   Active   46h
kube-public                       Active   46h
kube-system                       Active   46h
kubesphere-controls-system        Active   40h
kubesphere-monitoring-federated   Active   40h
kubesphere-monitoring-system      Active   40h
kubesphere-system                 Active   40h
openebs                           Active   41h
openelb-system                    Active   41h

:passport_control: Espace de travail (Namespaces)


<img src=images/Lens_NS.png width='' height='' > </img>

```
k get ns
```
> Retourne :
```yaml
NAME                              STATUS   AGE
default                           Active   46h
kube-node-lease                   Active   46h
kube-public                       Active   46h
kube-system                       Active   46h
kubesphere-controls-system        Active   40h
kubesphere-monitoring-federated   Active   40h
kubesphere-monitoring-system      Active   40h
kubesphere-system                 Active   41h
openebs                           Active   41h
openelb-system                    Active   41h
```

:factory: Charge de travail (Workloads)


<img src=images/Lens_Workloads.png width='' height='' > </img>

<img src=images/Lens_Kubesphere_Workloads.png width='' height='' > </img>

:roll_of_paper: Stockage

- [ ] Classe de stockage (Standard)

<img src=images/Lens_SC.png width='' height='' > </img>

```
k get sc
```
> Retourne :
```yaml
NAME                 PROVISIONER            RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
openebs-device       openebs.io/local       Delete          WaitForFirstConsumer   false                  41h
openebs-hostpath     openebs.io/local       Delete          WaitForFirstConsumer   false                  41h
standard (default)   cstor.csi.openebs.io   Delete          Immediate              true                   41h


- [ ] Volume pour persistence Réclamé 

<img src=images/Lens_PVC.png width='' height='' > </img>

```
k get pvc -n kubesphere-monitoring-system
```
> Retourne :
```yaml
NAME                                 STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
prometheus-k8s-db-prometheus-k8s-0   Bound    pvc-e8411c57-41ae-462c-bbeb-1ab05f8efc3e   20Gi       RWO            standard       40h
```

- [ ] Volume pour persistence

<img src=images/Lens_PV.png width='' height='' > </img>

```
k get pv
```
> Retourne :
```yaml
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                                                             STORAGECLASS   REASON   AGE
pvc-e8411c57-41ae-462c-bbeb-1ab05f8efc3e   20Gi       RWO            Delete           Bound    kubesphere-monitoring-system/prometheus-k8s-db-prometheus-k8s-0   standard                40h
```

:chains: Réseaux

:round_pushpin: Service

<img src=images/Lens_Services.png width='' height='' > </img>

```
k get svc -n kubesphere-controls-system
```
> Retourne :
```yaml
NAME                                          TYPE           CLUSTER-IP       EXTERNAL-IP    PORT(S)                      AGE
default-http-backend                          ClusterIP      10.100.28.11     <none>         80/TCP                       40h
kubesphere-router-kubesphere-system           LoadBalancer   10.109.112.117   10.13.15.200   80:31004/TCP,443:31317/TCP   16h
kubesphere-router-kubesphere-system-metrics   ClusterIP      10.106.234.252   <none>         10254/TCP                    16h
```
