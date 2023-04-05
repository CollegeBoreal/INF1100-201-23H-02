# :control_knobs: Le plan de contrôle (control plane)


:x: Le plan de contrôle est également appelé `master` mais ce terme devrait être utilisé avec rétention

:warning: Les commandes ci-dessous doivent se faire sur le serveur que vous avez choisi pour `plan de contrôle`

## :a: Installer le plan de contrôle

:round_pushpin: Télécharger les images (pour accélérer le processus)

```
sudo kubeadm config images pull
```

* Véfifier l'installation des images

```
sudo kubeadm config images list
```
> Return
<pre>
registry.k8s.io/kube-apiserver:v1.26.3
registry.k8s.io/kube-controller-manager:v1.26.3
registry.k8s.io/kube-scheduler:v1.26.3
registry.k8s.io/kube-proxy:v1.26.3
registry.k8s.io/pause:3.9
registry.k8s.io/etcd:3.5.6-0
registry.k8s.io/coredns/coredns:v1.9.3
</pre>

:round_pushpin: Initialiser la grappe

`<LE PLAN DE CONTROLE DE VOTRE GRAPPE>` doit être un nom de serveur avec son domaine par example `betelgeuse.gasy.africa`

```
sudo kubeadm init \
  --pod-network-cidr=172.16.0.0/16 \
  --control-plane-endpoint=<LE PLAN DE CONTROLE DE VOTRE GRAPPE>
```

#### :tada: Your Kubernetes control-plane has initialized successfully!

L'initialisation de la grappe va donner un long texte où se trouve un :tickets: jeton `--token` permettant:

- [ ] de récupérer le fichier de [configuration](control-plane.md#b-utiliser-sa-grappe-sur-le-serveur---plan-de-contrôle) :writing_hand: pour gérer la grappe
- [ ] d'initialiser le réseau de gousses (`pod network`) 
- [ ] de permettre aux autre noeux de `joindre` la grappe. 

Un example se trouve ci-dessous, sauvegarder l'information quelque part pour une future utilisation

```
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of control-plane nodes by copying certificate authorities
and service account keys on each node and then running the following as root:

  kubeadm join betelgeuse.boreal.codes:6443 --token 2pje0m.xl8voke0wisjymvp \
    --discovery-token-ca-cert-hash sha256:27c4b80df3d468bfe13517750a265bb3a3c560871e1bf177cafb323070b7b4a6 \
    --control-plane 

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join betelgeuse.boreal.codes:6443 --token 2pje0m.xl8voke0wisjymvp \
    --discovery-token-ca-cert-hash sha256:27c4b80df3d468bfe13517750a265bb3a3c560871e1bf177cafb323070b7b4a6
```

## :b: Utiliser sa grappe (sur le serveur - plan de contrôle)

:round_pushpin: Pour `contrôler` la grappe à partir du serveur, il faut utiliser l'outil de contrôle de grappes Kubernetes `kubectl`.

`kubectl` a besoin d'un fichier de configuration, `$HOME/.kube/config`.

Pour installer ce fichier de configuration, taper les commandes suivantes:

```
$ mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

Alternativement, si vous êtes l'utilisateur `root` , vous pouvez utiliser la commande:

```
# export KUBECONFIG=/etc/kubernetes/admin.conf
```

:round_pushpin: Vérifier le contexte courant (avec `kubectl`)

```
$ kubectl config get-contexts
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
*         kubernetes-admin@kubernetes   kubernetes   kubernetes-admin   
```

:round_pushpin: Vérifier les noeux

```
$ kubectl get nodes
NAME         STATUS     ROLES    AGE     VERSION
betelgeuse   NotReady   master   4m23s   v1.18.6
```

:warning: Not yet ready 


[:back:](../#control_knobs-le-plan-de-contrôle-control-plane)
