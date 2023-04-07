# :control_knobs: Le plan de contrôle (control plane)


:x: Le plan de contrôle est également appelé `master` mais ce terme devrait être utilisé avec rétention

:warning: Les commandes ci-dessous doivent se faire sur le serveur que vous avez choisi pour `plan de contrôle`

## :a: Installer le [plan de contrôle](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#initializing-your-control-plane-node)

:round_pushpin: Télécharger les images (pour accélérer le processus)

```
sudo kubeadm config images pull
```
> Return
<pre>
[config/images] Pulled registry.k8s.io/kube-apiserver:v1.26.3
[config/images] Pulled registry.k8s.io/kube-controller-manager:v1.26.3
[config/images] Pulled registry.k8s.io/kube-scheduler:v1.26.3
[config/images] Pulled registry.k8s.io/kube-proxy:v1.26.3
[config/images] Pulled registry.k8s.io/pause:3.9
[config/images] Pulled registry.k8s.io/etcd:3.5.6-0
[config/images] Pulled registry.k8s.io/coredns/coredns:v1.9.3
</pre>

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

`<LE PLAN DE CONTROLE DE VOTRE GRAPPE>` doit être un nom de serveur avec son domaine par example `betelgeuse.orion.gasy.africa`

```
sudo kubeadm init \
  --pod-network-cidr=172.16.0.0/16 \
  --control-plane-endpoint=<LE PLAN DE CONTROLE DE VOTRE GRAPPE>
```
> Retourne :
<pre>
[init] Using Kubernetes version: v1.26.3
[preflight] Running pre-flight checks
[preflight] Pulling images required for setting up a Kubernetes cluster
[preflight] This might take a minute or two, depending on the speed of your internet connection
[preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
[certs] Using certificateDir folder "/etc/kubernetes/pki"
[certs] Generating "ca" certificate and key
[certs] Generating "apiserver" certificate and key
[certs] apiserver serving cert is signed for DNS names [betelgeuse betelgeuse.orion.gasy.africa kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 10.13.15.200]
[certs] Generating "apiserver-kubelet-client" certificate and key
[certs] Generating "front-proxy-ca" certificate and key
[certs] Generating "front-proxy-client" certificate and key
[certs] Generating "etcd/ca" certificate and key
[certs] Generating "etcd/server" certificate and key
[certs] etcd/server serving cert is signed for DNS names [betelgeuse localhost] and IPs [10.13.15.200 127.0.0.1 ::1]
[certs] Generating "etcd/peer" certificate and key
[certs] etcd/peer serving cert is signed for DNS names [betelgeuse localhost] and IPs [10.13.15.200 127.0.0.1 ::1]
[certs] Generating "etcd/healthcheck-client" certificate and key
[certs] Generating "apiserver-etcd-client" certificate and key
[certs] Generating "sa" key and public key
[kubeconfig] Using kubeconfig folder "/etc/kubernetes"
[kubeconfig] Writing "admin.conf" kubeconfig file
[kubeconfig] Writing "kubelet.conf" kubeconfig file
[kubeconfig] Writing "controller-manager.conf" kubeconfig file
[kubeconfig] Writing "scheduler.conf" kubeconfig file
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Starting the kubelet
[control-plane] Using manifest folder "/etc/kubernetes/manifests"
[control-plane] Creating static Pod manifest for "kube-apiserver"
[control-plane] Creating static Pod manifest for "kube-controller-manager"
[control-plane] Creating static Pod manifest for "kube-scheduler"
[etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
[wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
[apiclient] All control plane components are healthy after 6.020423 seconds
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config" in namespace kube-system with the configuration for the kubelets in the cluster
[upload-certs] Skipping phase. Please see --upload-certs
[mark-control-plane] Marking the node betelgeuse as control-plane by adding the labels: [node-role.kubernetes.io/control-plane node.kubernetes.io/exclude-from-external-load-balancers]
[mark-control-plane] Marking the node betelgeuse as control-plane by adding the taints [node-role.kubernetes.io/control-plane:NoSchedule]
[bootstrap-token] Using token: n9l9m5.rybwerit049a7nne
[bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to get nodes
[bootstrap-token] Configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstrap-token] Configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstrap-token] Configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[bootstrap-token] Creating the "cluster-info" ConfigMap in the "kube-public" namespace
[kubelet-finalize] Updating "/etc/kubernetes/kubelet.conf" to point to a rotatable kubelet client certificate and key
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of control-plane nodes by copying certificate authorities
and service account keys on each node and then running the following as root:

  kubeadm join betelgeuse.orion.gasy.africa:6443 --token n9l9m5.rybwerit049a7nne \
	--discovery-token-ca-cert-hash sha256:0f7f4ef13e42f17f2036032cf1aedd110374349c478a26e347c99766afdc53c0 \
	--control-plane 

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join betelgeuse.orion.gasy.africa:6443 --token n9l9m5.rybwerit049a7nne \
	--discovery-token-ca-cert-hash sha256:0f7f4ef13e42f17f2036032cf1aedd110374349c478a26e347c99766afdc53c0
</pre>

#### :tada: Your Kubernetes control-plane has initialized successfully!

L'initialisation de la grappe va donner un long texte où se trouve un :tickets: jeton `--token` permettant:

- [ ] de récupérer le fichier de [configuration](control-plane.md#b-utiliser-sa-grappe-sur-le-serveur---plan-de-contrôle) :writing_hand: pour gérer la grappe
- [ ] d'initialiser le réseau de gousses (`pod network`) 
- [ ] de permettre aux autre noeux de `joindre` la grappe. 

Un example se trouve ci-dessous, sauvegarder l'information quelque part pour une future utilisation

```yaml
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of control-plane nodes by copying certificate authorities
and service account keys on each node and then running the following as root:

  kubeadm join betelgeuse.orion.gasy.africa:6443 --token n9l9m5.rybwerit049a7nne \
        --discovery-token-ca-cert-hash sha256:0f7f4ef13e42f17f2036032cf1aedd110374349c478a26e347c99766afdc53c0 \
        --control-plane 

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join betelgeuse.orion.gasy.africa:6443 --token n9l9m5.rybwerit049a7nne \
        --discovery-token-ca-cert-hash sha256:0f7f4ef13e42f17f2036032cf1aedd110374349c478a26e347c99766afdc53c0
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

:round_pushpin: Vérifier l'information sur la grappe

```
kubectl cluster-info
```
> Retourne :
```yaml 
Kubernetes control plane is running at https://betelgeuse.orion.gasy.africa:6443
CoreDNS is running at https://betelgeuse.orion.gasy.africa:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

:warning: Not yet ready 


[:back:](../#control_knobs-le-plan-de-contrôle-control-plane)


## :x: TroubleShooting: CRI v1 runtime API is not implemented

- [ ] [kubeadm init error: CRI v1 runtime API is not implemented](https://forum.linuxfoundation.org/discussion/862825/kubeadm-init-error-cri-v1-runtime-api-is-not-implemented)

* `validate service connection: CRI v1 image API is not implemented for endpoint "unix:///var/run/containerd/containerd.sock"`

:round_pushpin: Si vous rencontrez cette erreur, c'est que le [CRI](https://kubernetes.io/docs/concepts/architecture/cri/) ne vient pas avec Docker Engine par défaut 

```
sudo kubeadm config images pull
```
> Retourne :
<pre> 
failed to pull image "registry.k8s.io/kube-apiserver:v1.26.3": output: time="2023-04-06T21:11:34Z" level=fatal msg="validate service connection: CRI v1 image API is not implemented for endpoint \"unix:///var/run/containerd/containerd.sock\": rpc error: code = Unimplemented desc = unknown service runtime.v1.ImageService"
, error: exit status 1
To see the stack trace of this error execute with --v=5 or higher
</pre>

:round_pushpin: Installer le `CRI`  

- [ ] Enlever le vieux paquet `containerd` au cas oû il est installé

* Supprimer le fichier de configuration 

```
sudo mv /etc/containerd/config.toml
```

* Supprimer le paquet

```
sudo apt remove containerd
```
> Retourne :
<pre>
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Package 'containerd' is not installed, so not removed
0 upgraded, 0 newly installed, 0 to remove and 5 not upgraded.
</pre>

- [ ] Installer le paquet `containerd`

```
sudo apt update, apt install containerd.io
```
> Retourne :
```yaml
Hit:1 https://download.docker.com/linux/ubuntu focal InRelease
Hit:3 http://ca.archive.ubuntu.com/ubuntu jammy InRelease                                 
Hit:4 http://ca.archive.ubuntu.com/ubuntu jammy-updates InRelease
Hit:5 http://ca.archive.ubuntu.com/ubuntu jammy-backports InRelease              
Hit:6 http://ca.archive.ubuntu.com/ubuntu jammy-security InRelease               
Hit:2 https://packages.cloud.google.com/apt kubernetes-xenial InRelease
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
5 packages can be upgraded. Run 'apt list --upgradable' to see them.
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following packages will be upgraded:
  containerd.io
1 upgraded, 0 newly installed, 0 to remove and 4 not upgraded.
Need to get 28.3 MB of archives.
After this operation, 287 kB of additional disk space will be used.
Get:1 https://download.docker.com/linux/ubuntu focal/stable amd64 containerd.io amd64 1.6.20-1 [28.3 MB]
Fetched 28.3 MB in 2s (14.9 MB/s)         
(Reading database ... 76063 files and directories currently installed.)
Preparing to unpack .../containerd.io_1.6.20-1_amd64.deb ...
Unpacking containerd.io (1.6.20-1) over (1.6.19-1) ...
Setting up containerd.io (1.6.20-1) ...
Processing triggers for man-db (2.10.2-1) ...
Scanning processes...                                                                                            
Scanning processor microcode...                                                                                  
Scanning linux images...                                                                                         

Running kernel seems to be up-to-date.

The processor microcode seems to be up-to-date.

No services need to be restarted.

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.
```

- [ ] Vérifier que le service `containerd` est disponible au démarrage

```
systemctl is-enabled containerd
```
> enabled

- [ ] Par précaution redémarrer le service `containerd`

```
sudo systemctl restart containerd
```

- [ ] Vérifier le service `containerd`

```
systemctl status containerd
```
> Retourne :
```yaml
● containerd.service - containerd container runtime
     Loaded: loaded (/lib/systemd/system/containerd.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2023-04-06 21:47:37 UTC; 27s ago
       Docs: https://containerd.io
    Process: 21239 ExecStartPre=/sbin/modprobe overlay (code=exited, status=0/SUCCESS)
   Main PID: 21240 (containerd)
      Tasks: 79
     Memory: 989.9M
        CPU: 552ms
     CGroup: /system.slice/containerd.service
             ├─20551 /usr/bin/containerd-shim-runc-v2 -namespace k8s.io -id e61797e6a29a2c792dedf0335a50edd7c885>
             ├─20695 /usr/bin/containerd-shim-runc-v2 -namespace k8s.io -id 38ad2171522ac19d75609efad8c3f8de2068>
             ├─21038 /usr/bin/containerd-shim-runc-v2 -namespace k8s.io -id 7e49fdad2c5fae362342f15ea887ad8ebed9>
             ├─21146 /usr/bin/containerd-shim-runc-v2 -namespace k8s.io -id 7e93f53ddea0c4fbb6c32b0adbf5a082b713>
             ├─21240 /usr/bin/containerd
             └─21336 /usr/bin/containerd-shim-runc-v2 -namespace k8s.io -id 9bac2b13accab20c16accaa16d536d6eb5b9>

Apr 06 21:47:55 betelgeuse containerd[21240]: time="2023-04-06T21:47:55.407533370Z" level=info msg="StopPodSandb>
Apr 06 21:47:55 betelgeuse containerd[21240]: time="2023-04-06T21:47:55.407825344Z" level=info msg="StopPodSandb>
Apr 06 21:47:55 betelgeuse containerd[21240]: time="2023-04-06T21:47:55.407927724Z" level=info msg="TearDown net>
lines 1-20
```

* taper sur `q` pour quitter

```
kubectl cluster-info
```
> Retourne :
```yaml 
E0406 22:18:44.965424   30582 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E0406 22:18:44.965727   30582 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E0406 22:18:44.967079   30582 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E0406 22:18:44.968782   30582 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
E0406 22:18:44.970568   30582 memcache.go:265] couldn't get current server API group list: Get "http://localhost:8080/api?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused
```
