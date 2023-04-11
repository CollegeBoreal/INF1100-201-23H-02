# OpenELB



## :o2: [Installer OpenELB](https://openelb.io/docs/getting-started/installation/install-openelb-on-kubernetes/)

- [ ] Exécuter l'installation du manifeste ci-dessous

```
kubectl apply -f https://raw.githubusercontent.com/openelb/openelb/master/deploy/openelb.yaml
```
> Retourne :
```yaml
namespace/openelb-system created
customresourcedefinition.apiextensions.k8s.io/bgpconfs.network.kubesphere.io created
customresourcedefinition.apiextensions.k8s.io/bgppeers.network.kubesphere.io created
customresourcedefinition.apiextensions.k8s.io/eips.network.kubesphere.io created
serviceaccount/kube-keepalived-vip created
serviceaccount/openelb-admission created
role.rbac.authorization.k8s.io/leader-election-role created
role.rbac.authorization.k8s.io/openelb-admission created
clusterrole.rbac.authorization.k8s.io/kube-keepalived-vip created
clusterrole.rbac.authorization.k8s.io/openelb-admission created
clusterrole.rbac.authorization.k8s.io/openelb-manager-role created
rolebinding.rbac.authorization.k8s.io/leader-election-rolebinding created
rolebinding.rbac.authorization.k8s.io/openelb-admission created
clusterrolebinding.rbac.authorization.k8s.io/kube-keepalived-vip created
clusterrolebinding.rbac.authorization.k8s.io/openelb-admission created
clusterrolebinding.rbac.authorization.k8s.io/openelb-manager-rolebinding created
service/openelb-admission created
deployment.apps/openelb-manager created
job.batch/openelb-admission-create created
job.batch/openelb-admission-patch created
mutatingwebhookconfiguration.admissionregistration.k8s.io/openelb-admission created
validatingwebhookconfiguration.admissionregistration.k8s.io/openelb-admission created
```

- [ ] Vérifier que `openelb` est installé

```
kubectl get po -n openelb-system
```
> Retourne :
```yaml
NAME                              READY   STATUS      RESTARTS   AGE
openelb-admission-create-g6njd    0/1     Completed   0          41s
openelb-admission-patch-67s8r     0/1     Completed   0          41s
openelb-keepalive-vip-8mtzf       1/1     Running     0          27s
openelb-manager-d6df4dfc4-24lml   1/1     Running     0          41s
```

## :round_pushpin: Créer l'objet EIP (External IP) 

L'objet [`Eip`](https://openelb.io/docs/getting-started/configuration/configure-ip-address-pools-using-eip/) functionne comme un réservoir d'adresse IP pour Porter.

Exécutez la commande suivante pour créer un fichier YAML pour l '«objet Eip»:

- [ ] Récupérer le nom de l'interface "NIC" (i.e. `enp3s0f0`)

```
$ ip addr | grep 10.13.237
    inet 10.13.237.14/24 brd 10.13.237.255 scope global enp3s0f0
```

:round_pushpin: Sauveguarder le fichier `openelb.yaml`

- [ ] modifiez les informations du réservoir d'IP dans le champ `{spec.address}` (i.e. `10.13.237.8-10.13.237.11`) séparé par un `-`
> le réservoir d'IP représente le premier serveur, soit le plan de contrôle :control_knobs: aux derniers serveurs :1st_place_medal:, :2nd_place_medal:, :3rd_place_medal: noeuds de la grappe  
- [ ] modifiez l'informations de l'interface "NIC" dans le champ `{spec.interface}` (i.e. `enp3s0f0`)
- [ ] après avoir modifier les informations sauvegarder sous le nom `porterlb.md` dans le répertoire de votre grappe
- [ ] Exécuter la commande `kubectl` à partir du fichier.


```yaml
apiVersion: network.kubesphere.io/v1alpha2
kind: Eip
metadata:
    name: openelb-layer2-eip
    annotations:
      eip.openelb.kubesphere.io/is-default-eip: "true"
spec:
    address: 10.13.237.8-10.13.237.11  # CHANGEZ MOI VITE
    protocol: layer2
    interface: enp3s0f0.  # CHANGEZ MOI VITE
    disable: false
status:
    occupied: false
    usage: 1
    poolSize: 10
    used: 
      "10.13.237.8": "default/test-svc" # CHANGEZ MOI VITE
    firstIP: 10.13.237.8 # CHANGEZ MOI VITE
    lastIP: 10.13.237.11 # CHANGEZ MOI VITE
    ready: true
    v4: true
```

- [ ] Executer

```
kubectl apply --filename openelb.yaml
```
> eip.network.kubesphere.io/openelb-layer2-eip created

## [:back:](../#rocket-les-services)

# References

- [ ] [Configure IP Address Pools Using Eip](https://openelb.io/docs/getting-started/configuration/configure-ip-address-pools-using-eip)

:warning Référence uniquement **ne pas éxécuter**

## :round_pushpin: Permettre strictARP à kube-proxy

En mode Couche 2, vous devez activer `strictARP` pour `kube-proxy` afin que toutes les cartes réseaux de la grappe Kubernetes cessent de répondre aux requêtes `ARP` des autres cartes réseaux et que Porter gère les requêtes `ARP` à leur place.

- [ ] Exécuter la commande suivante pour [éditer](https://jamesdefabia.github.io/docs/user-guide/kubectl/kubectl_edit) le `kube-proxy ConfigMap`:

```
$ kubectl edit configmap kube-proxy --namespace kube-system
```

:bulb: Pour utiliser `nano` en tant qu'éditeur

```
$ KUBE_EDITOR="nano" kubectl edit configmap kube-proxy --namespace kube-system
```

- [ ] Dans la configuration `kube-proxy ConfigMap YAML`, mettre `data.config.conf.ipvs.strictARP` à `true`.

```yaml
ipvs:
  strictARP: true
```

- [ ] Exécutez la commande suivante pour redémarrer `kube-proxy`:

```
$ kubectl rollout restart daemonset kube-proxy --namespace kube-system
```

## :round_pushpin: Spécifiez la carte réseau à utiliser pour Porter

Si le nœud sur lequel Porter est installé a plusieurs «NIC», vous devez spécifier le «NIC» utilisé pour Porter en mode «Layer 2». Vous pouvez ignorer cette étape si le nœud n'a qu'un seul «NIC».

Exécuter la commande suivante sur :control_knobs: le plan de contrôle pour annoter le `NIC` à une adresse IP spécifique:

- [ ] remplacer `betelgeuse` par le nom du serveur de votre plan de contrôle
- [ ] remplacer l'adress IP `10.13.237.10` par l'adresse du serveur de votre plan de contrôle

```
$ kubectl annotate nodes betelgeuse \
          layer2.porter.kubesphere.io/v1alpha1="10.13.237.10"
```



