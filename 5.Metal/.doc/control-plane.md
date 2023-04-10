# :control_knobs: Le plan de contrôle (control plane)


:x: Le plan de contrôle est également appelé `master` mais ce terme devrait être utilisé avec rétention

:warning: Les commandes ci-dessous doivent se faire sur le serveur que vous avez choisi pour `plan de contrôle`

La version par défaut de `Docker` ne vient pas avec le CRI (`containerd`) il faut l'installer

## :a: Installer le [plan de contrôle](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#initializing-your-control-plane-node)


#### :construction: Attention assurer vous d'avoir installé le [CRI](#x-troubleshooting-cri-v1-runtime-api-is-not-implemented) :construction:

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
```yaml
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
[apiclient] All control plane components are healthy after 7.518603 seconds
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config" in namespace kube-system with the configuration for the kubelets in the cluster
[upload-certs] Skipping phase. Please see --upload-certs
[mark-control-plane] Marking the node betelgeuse as control-plane by adding the labels: [node-role.kubernetes.io/control-plane node.kubernetes.io/exclude-from-external-load-balancers]
[mark-control-plane] Marking the node betelgeuse as control-plane by adding the taints [node-role.kubernetes.io/control-plane:NoSchedule]
[bootstrap-token] Using token: lj75gj.bqlmhxx602fhbdm2
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

  kubeadm join betelgeuse.orion.gasy.africa:6443 --token lj75gj.bqlmhxx602fhbdm2 \
	--discovery-token-ca-cert-hash sha256:6a69a424ba80d08a99e612f3f2848cc7255a15aa4172d66bb561d1a04a47561c \
	--control-plane 

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join betelgeuse.orion.gasy.africa:6443 --token lj75gj.bqlmhxx602fhbdm2 \
	--discovery-token-ca-cert-hash sha256:6a69a424ba80d08a99e612f3f2848cc7255a15aa4172d66bb561d1a04a47561c 
```

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


## :x: TroubleShooting: 

- [ ] [kubeadm init error: CRI v1 runtime API is not implemented](https://forum.linuxfoundation.org/discussion/862825/kubeadm-init-error-cri-v1-runtime-api-is-not-implemented)

* `validate service connection: CRI v1 image API is not implemented for endpoint "unix:///var/run/containerd/containerd.sock"`

:round_pushpin: Si vous rencontrez cette erreur, c'est que le [CRI](https://kubernetes.io/docs/concepts/architecture/cri/) (i.e. containerd) n'est pas installé. Depuis la version de kubenetes 1.19 le CRI ne vient pas avec Docker Engine par défaut 

```
sudo kubeadm config images pull
```
> Retourne :
<pre> 
failed to pull image "registry.k8s.io/kube-apiserver:v1.26.3": output: time="2023-04-06T21:11:34Z" level=fatal msg="validate service connection: CRI v1 image API is not implemented for endpoint \"unix:///var/run/containerd/containerd.sock\": rpc error: code = Unimplemented desc = unknown service runtime.v1.ImageService"
, error: exit status 1
To see the stack trace of this error execute with --v=5 or higher
</pre>

:round_pushpin: preflight] Running pre-flight checks

```
sudo kubeadm init \
  --pod-network-cidr=172.16.0.0/16 \
  --control-plane-endpoint=rukbat.sagittarius.valiha.com
```
```yaml
[init] Using Kubernetes version: v1.26.3
[preflight] Running pre-flight checks
error execution phase preflight: [preflight] Some fatal errors occurred:
	[ERROR FileContent--proc-sys-net-bridge-bridge-nf-call-iptables]: /proc/sys/net/bridge/bridge-nf-call-iptables does not exist
	[ERROR FileContent--proc-sys-net-ipv4-ip_forward]: /proc/sys/net/ipv4/ip_forward contents are not set to 1
[preflight] If you know what you are doing, you can make a check non-fatal with `--ignore-preflight-errors=...`
To see the stack trace of this error execute with --v=5 or higher
```


:round_pushpin: Debug with logs

```
tail -f /var/log/syslog |grep kube-apiserver
```
```yaml
Apr  9 22:00:09 betelgeuse kubelet[1003697]: I0409 22:00:09.512638 1003697 status_manager.go:698] "Failed to get status for pod" podUID=4008dce9245d5ce36f28ab2ace9bec53 pod="kube-system/kube-apiserver-betelgeuse" err="Get \"https://betelgeuse.orion.gasy.africa:6443/api/v1/namespaces/kube-system/pods/kube-apiserver-betelgeuse\": dial tcp 10.13.15.200:6443: connect: connection refused"
Apr  9 22:00:10 betelgeuse kubelet[1003697]: E0409 22:00:10.422352 1003697 pod_workers.go:965] "Error syncing pod, skipping" err="failed to \"StartContainer\" for \"kube-apiserver\" with CrashLoopBackOff: \"back-off 5m0s restarting failed container=kube-apiserver pod=kube-apiserver-betelgeuse_kube-system(4008dce9245d5ce36f28ab2ace9bec53)\"" pod="kube-system/kube-apiserver-betelgeuse" podUID=4008dce9245d5ce36f28ab2ace9bec53
Apr  9 22:00:19 betelgeuse kubelet[1003697]: I0409 22:00:19.483794 1003697 status_manager.go:698] "Failed to get status for pod" podUID=4008dce9245d5ce36f28ab2ace9bec53 pod="kube-system/kube-apiserver-betelgeuse" err="Get \"https://betelgeuse.orion.gasy.africa:6443/api/v1/namespaces/kube-system/pods/kube-apiserver-betelgeuse\": dial tcp 10.13.15.200:6443: connect: connection refused"
Apr  9 22:00:25 betelgeuse kubelet[1003697]: E0409 22:00:25.464617 1003697 pod_workers.go:965] "Error syncing pod, skipping" err="failed to \"StartContainer\" for \"kube-apiserver\" with CrashLoopBackOff: \"back-off 5m0s restarting failed container=kube-apiserver pod=kube-apiserver-betelgeuse_kube-system(4008dce9245d5ce36f28ab2ace9bec53)\"" pod="kube-system/kube-apiserver-betelgeuse" podUID=4008dce9245d5ce36f28ab2ace9bec53
Apr  9 22:00:29 betelgeuse kubelet[1003697]: I0409 22:00:29.457432 1003697 status_manager.go:698] "Failed to get status for pod" podUID=4008dce9245d5ce36f28ab2ace9bec53 pod="kube-system/kube-apiserver-betelgeuse" err="Get \"https://betelgeuse.orion.gasy.africa:6443/api/v1/namespaces/kube-system/pods/kube-apiserver-betelgeuse\": dial tcp 10.13.15.200:6443: connect: connection refused"
Apr  9 22:00:34 betelgeuse kubelet[1003697]: E0409 22:00:34.547180 1003697 event.go:276] Unable to write event: '&v1.Event{TypeMeta:v1.TypeMeta{Kind:"", APIVersion:""}, ObjectMeta:v1.ObjectMeta{Name:"kube-apiserver-betelgeuse.175426958d9badd4", GenerateName:"", Namespace:"kube-system", SelfLink:"", UID:"", ResourceVersion:"19198", Generation:0, CreationTimestamp:time.Date(1, time.January, 1, 0, 0, 0, 0, time.UTC), DeletionTimestamp:<nil>, DeletionGracePeriodSeconds:(*int64)(nil), Labels:map[string]string(nil), Annotations:map[string]string(nil), OwnerReferences:[]v1.OwnerReference(nil), Finalizers:[]string(nil), ManagedFields:[]v1.ManagedFieldsEntry(nil)}, InvolvedObject:v1.ObjectReference{Kind:"Pod", Namespace:"kube-system", Name:"kube-apiserver-betelgeuse", UID:"4008dce9245d5ce36f28ab2ace9bec53", APIVersion:"v1", ResourceVersion:"", FieldPath:"spec.containers{kube-apiserver}"}, Reason:"BackOff", Message:"Back-off restarting failed container kube-apiserver in pod kube-apiserver-betelgeuse_kube-system(4008dce9245d5ce36f28ab2ace9bec53)", Source:v1.EventSource{Component:"kubelet", Host:"betelgeuse"}, FirstTimestamp:time.Date(2023, time.April, 9, 3, 29, 44, 0, time.Local), LastTimestamp:time.Date(2023, time.April, 9, 21, 16, 59, 497376398, time.Local), Count:2445, Type:"Warning", EventTime:time.Date(1, time.January, 1, 0, 0, 0, 0, time.UTC), Series:(*v1.EventSeries)(nil), Action:"", Related:(*v1.ObjectReference)(nil), ReportingController:"", ReportingInstance:""}': 'Patch "https://betelgeuse.orion.gasy.africa:6443/api/v1/namespaces/kube-system/events/kube-apiserver-betelgeuse.175426958d9badd4": dial tcp 10.13.15.200:6443: connect: connection refused'(may retry after sleeping)
Apr  9 22:00:37 betelgeuse kubelet[1003697]: E0409 22:00:37.193812 1003697 event.go:276] Unable to write event: '&v1.Event{TypeMeta:v1.TypeMeta{Kind:"", APIVersion:""}, ObjectMeta:v1.ObjectMeta{Name:"kube-apiserver-betelgeuse.175426958d9badd4", GenerateName:"", Namespace:"kube-system", SelfLink:"", UID:"", ResourceVersion:"19198", Generation:0, CreationTimestamp:time.Date(1, time.January, 1, 0, 0, 0, 0, time.UTC), DeletionTimestamp:<nil>, DeletionGracePeriodSeconds:(*int64)(nil), Labels:map[string]string(nil), Annotations:map[string]string(nil), OwnerReferences:[]v1.OwnerReference(nil), Finalizers:[]string(nil), ManagedFields:[]v1.ManagedFieldsEntry(nil)}, InvolvedObject:v1.ObjectReference{Kind:"Pod", Namespace:"kube-system", Name:"kube-apiserver-betelgeuse", UID:"4008dce9245d5ce36f28ab2ace9bec53", APIVersion:"v1", ResourceVersion:"", FieldPath:"spec.containers{kube-apiserver}"}, Reason:"BackOff", Message:"Back-off restarting failed container kube-apiserver in pod kube-apiserver-betelgeuse_kube-system(4008dce9245d5ce36f28ab2ace9bec53)", Source:v1.EventSource{Component:"kubelet", Host:"betelgeuse"}, FirstTimestamp:time.Date(2023, time.April, 9, 3, 29, 44, 0, time.Local), LastTimestamp:time.Date(2023, time.April, 9, 21, 16, 59, 497376398, time.Local), Count:2445, Type:"Warning", EventTime:time.Date(1, time.January, 1, 0, 0, 0, 0, time.UTC), Series:(*v1.EventSeries)(nil), Action:"", Related:(*v1.ObjectReference)(nil), ReportingController:"", ReportingInstance:""}': 'Patch "https://betelgeuse.orion.gasy.africa:6443/api/v1/namespaces/kube-system/events/kube-apiserver-betelgeuse.175426958d9badd4": dial tcp 10.13.15.200:6443: connect: connection refused'(may retry after sleeping)
```



```
sudo iptables -L -t nat | grep KUBE
```
```yaml
KUBE-SERVICES  all  --  anywhere             anywhere             /* kubernetes service portals */
KUBE-SERVICES  all  --  anywhere             anywhere             /* kubernetes service portals */
KUBE-POSTROUTING  all  --  anywhere             anywhere             /* kubernetes postrouting rules */
Chain KUBE-KUBELET-CANARY (0 references)
Chain KUBE-MARK-DROP (0 references)
Chain KUBE-MARK-MASQ (2 references)
Chain KUBE-NODEPORTS (1 references)
Chain KUBE-POSTROUTING (1 references)
Chain KUBE-PROXY-CANARY (0 references)
Chain KUBE-SEP-SZZALUCJCNWECXUR (1 references)
KUBE-MARK-MASQ  all  --  betelgeuse           anywhere             /* default/kubernetes:https */
Chain KUBE-SERVICES (2 references)
KUBE-SVC-NPX46M4PTMTKRN6Y  tcp  --  anywhere             10.96.0.1            /* default/kubernetes:https cluster IP */ tcp dpt:https
KUBE-NODEPORTS  all  --  anywhere             anywhere             /* kubernetes service nodeports; NOTE: this must be the last rule in this chain */ ADDRTYPE match dst-type LOCAL
Chain KUBE-SVC-NPX46M4PTMTKRN6Y (1 references)
KUBE-MARK-MASQ  tcp  -- !172.16.0.0/16        10.96.0.1            /* default/kubernetes:https cluster IP */ tcp dpt:https
KUBE-SEP-SZZALUCJCNWECXUR  all  --  anywhere             anywhere             /* default/kubernetes:https -> 10.13.15.200:6443 */
```

```
sudo iptables -L -t nat | grep cali
```
```yaml
cali-PREROUTING  all  --  anywhere             anywhere             /* cali:6gwbT8clXdHdC1b1 */
cali-OUTPUT  all  --  anywhere             anywhere             /* cali:tVnHkvAo15HuiPy0 */
cali-POSTROUTING  all  --  anywhere             anywhere             /* cali:O3lYWMrLQYEMJtB5 */
Chain cali-OUTPUT (1 references)
cali-fip-dnat  all  --  anywhere             anywhere             /* cali:GBTAv2p5CwevEyJm */
Chain cali-POSTROUTING (1 references)
cali-fip-snat  all  --  anywhere             anywhere             /* cali:Z-c7XtVd2Bq7s_hA */
cali-nat-outgoing  all  --  anywhere             anywhere             /* cali:nYKhEzDlr11Jccal */
MASQUERADE  all  --  anywhere             anywhere             /* cali:SXWvdsbh4Mw7wOln */ ADDRTYPE match src-type !LOCAL limit-out ADDRTYPE match src-type LOCAL random-fully
Chain cali-PREROUTING (1 references)
cali-fip-dnat  all  --  anywhere             anywhere             /* cali:r6XmIziWUJsdOK6Z */
Chain cali-fip-dnat (2 references)
Chain cali-fip-snat (1 references)
Chain cali-nat-outgoing (1 references)
MASQUERADE  all  --  anywhere             anywhere             /* cali:flqWnvo8yq4ULQLa */ match-set cali40masq-ipam-pools src ! match-set cali40all-ipam-pools dst random-fully
```
