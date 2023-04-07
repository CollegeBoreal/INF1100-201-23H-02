# :droplet: CNI Plugin

Installer the CNI Plugin pour gérer le réseau de gousses [Cluster Networking](https://kubernetes.io/docs/concepts/cluster-administration/networking/)

* Exécuter "kubectl apply -f [podnetwork].yaml" with one of the options listed at:

  https://kubernetes.io/docs/concepts/cluster-administration/addons/

## :a: Installer le plugin CNI


- [ ] Le plugin CNI a utiliser est [Calico]([https://projectcalico.org](https://docs.tigera.io/calico/latest/getting-started/kubernetes/self-managed-onprem/onpremises#install-calico-with-kubernetes-api-datastore-50-nodes-or-less))

Sur le serveur du plan de contrôle:

* Télécharger le fichier `manifest` appellé `calico.yaml`

```
curl https://raw.githubusercontent.com/projectcalico/calico/v3.25.1/manifests/calico.yaml -O
```

* Charger le fichier `calico.yaml`

```
kubectl apply --filename=calico.yaml
```
> Retourne :
```yaml
poddisruptionbudget.policy/calico-kube-controllers created
serviceaccount/calico-kube-controllers created
serviceaccount/calico-node created
configmap/calico-config created
customresourcedefinition.apiextensions.k8s.io/bgpconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/bgppeers.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/blockaffinities.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/caliconodestatuses.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/clusterinformations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/felixconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/globalnetworkpolicies.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/globalnetworksets.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/hostendpoints.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamblocks.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamconfigs.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamhandles.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ippools.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipreservations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/kubecontrollersconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/networkpolicies.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/networksets.crd.projectcalico.org created
clusterrole.rbac.authorization.k8s.io/calico-kube-controllers created
clusterrole.rbac.authorization.k8s.io/calico-node created
clusterrolebinding.rbac.authorization.k8s.io/calico-kube-controllers created
clusterrolebinding.rbac.authorization.k8s.io/calico-node created
daemonset.apps/calico-node created
deployment.apps/calico-kube-controllers created
```

- [ ] Vérifier le service :droplet: `Kubelet` après l'installation du plugin CNI

La trace de `calico` doit apparaître

```
sudo systemctl status kubelet
```
> Retourne :
<pre> 
[sudo] password for ubuntu: 
● kubelet.service - kubelet: The Kubernetes Node Agent
     Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
    Drop-In: /etc/systemd/system/kubelet.service.d
             └─10-kubeadm.conf
     Active: active (running) since Wed 2021-02-17 22:52:11 UTC; 3h 45min ago
       Docs: https://kubernetes.io/docs/home/
   Main PID: 1130554 (kubelet)
      Tasks: 27 (limit: 77183)
     Memory: 59.2M
     CGroup: /system.slice/kubelet.service
             └─1130554 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet>

Feb 18 02:36:35 orion kubelet[1130554]: 2021-02-18 02:36:35.422 [INFO][1182279] ipam.go 970: Writing block in order to claim IPs block=192>
Feb 18 02:36:35 orion kubelet[1130554]: 2021-02-18 02:36:35.426 [INFO][1182279] ipam.go 983: Successfully claimed IPs: [192.168.46.3/26] b>
Feb 18 02:36:35 orion kubelet[1130554]: 2021-02-18 02:36:35.426 [INFO][1182279] ipam.go 706: Auto-assigned 1 out of 1 IPv4s: [192.168.46.3>
Feb 18 02:36:35 orion kubelet[1130554]: 2021-02-18 02:36:35.427 [INFO][1182279] ipam_plugin.go 255: Calico CNI IPAM assigned addresses IPv>
Feb 18 02:36:35 orion kubelet[1130554]: 2021-02-18 02:36:35.428 [INFO][1182250] k8s.go 372: Populated endpoint ContainerID="f947f87d7d0bdd>
Feb 18 02:36:35 orion kubelet[1130554]: 2021-02-18 02:36:35.429 [INFO][1182250] k8s.go 373: Calico CNI using IPs: [192.168.46.3/32] Contai>
Feb 18 02:36:35 orion kubelet[1130554]: 2021-02-18 02:36:35.429 [INFO][1182250] dataplane_linux.go 66: Setting the host side veth name to >
Feb 18 02:36:35 orion kubelet[1130554]: 2021-02-18 02:36:35.434 [INFO][1182250] dataplane_linux.go 420: Disabling IPv4 forwarding Containe>
Feb 18 02:36:35 orion kubelet[1130554]: 2021-02-18 02:36:35.472 [INFO][1182250] k8s.go 400: Added Mac, interface name, and active containe>
Feb 18 02:36:35 orion kubelet[1130554]: 2021-02-18 02:36:35.483 [INFO][1182250] k8s.go 474: Wrote updated endpoint to datastore ContainerI>
lines 1-22/22 (END)
</pre> 

[:back:](../#control_knobs-le-plan-de-contrôle-control-plane)


## :x: Troubleshooting

#### :round_pushpin: [Restart kube-apiserver when provisioned with kubeadm](https://stackoverflow.com/questions/42674726/restart-kube-apiserver-when-provisioned-with-kubeadm)

:construction: Si on perd le `kube-apiserver` à cause d'une commande (i.e. CNI)

- [ ] :one: initialiser l'heure du fichier de configuration `kube-apiserver.yaml` avec `touch`

```
sudo touch /etc/kubernetes/manifests/kube-apiserver.yaml

```

- [ ] :two: Redémarrer le service `kubelet`

```
sudo systemctl restart kubelet
```

- [ ] :two: Enlever la commande fautive (i.e. CNI)

```
k delete -f calico.yaml
```


#### :round_pushpin: Nettoyer la grappe

```
kubectl drain betelgeuse --delete-emptydir-data --ignore-daemonsets --force
```

```
k get no
```
> Retourne :
<pre> 
NAME         STATUS                     ROLES           AGE     VERSION
betelgeuse   Ready,SchedulingDisabled   control-plane   4h17m   v1.26.3
</pre> 

#### :skull_and_crossbones: Réinitialiser la grappe

```
sudo kubeadm reset
```
> Retourne :
```yaml 
[reset] Reading configuration from the cluster...
[reset] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
W0407 02:30:51.874637  313090 reset.go:106] [reset] Unable to fetch the kubeadm-config ConfigMap from cluster: failed to get config map: Get "https://betelgeuse.orion.gasy.africa:6443/api/v1/namespaces/kube-system/configmaps/kubeadm-config?timeout=10s": dial tcp 10.13.15.200:6443: connect: connection refused
W0407 02:30:51.874813  313090 preflight.go:56] [reset] WARNING: Changes made to this host by 'kubeadm init' or 'kubeadm join' will be reverted.
[reset] Are you sure you want to proceed? [y/N]: y
[preflight] Running pre-flight checks
W0407 02:30:53.179610  313090 removeetcdmember.go:106] [reset] No kubeadm config, using etcd pod spec to get data directory
[reset] Deleted contents of the etcd data directory: /var/lib/etcd
[reset] Stopping the kubelet service
[reset] Unmounting mounted directories in "/var/lib/kubelet"
W0407 02:30:58.350633  313090 cleanupnode.go:99] [reset] Failed to remove containers: [failed to stop running pod f08820ced9f1c9a3d364c4eca7a0804a34b3722afa7cb8e7e1c121a852ae1547: output: E0407 02:30:55.283286  314011 remote_runtime.go:205] "StopPodSandbox from runtime service failed" err="rpc error: code = Unknown desc = failed to destroy network for sandbox \"f08820ced9f1c9a3d364c4eca7a0804a34b3722afa7cb8e7e1c121a852ae1547\": plugin type=\"calico\" failed (delete): error getting ClusterInformation: Get \"https://10.96.0.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default\": dial tcp 10.96.0.1:443: connect: connection refused" podSandboxID="f08820ced9f1c9a3d364c4eca7a0804a34b3722afa7cb8e7e1c121a852ae1547"
time="2023-04-07T02:30:55Z" level=fatal msg="stopping the pod sandbox \"f08820ced9f1c9a3d364c4eca7a0804a34b3722afa7cb8e7e1c121a852ae1547\": rpc error: code = Unknown desc = failed to destroy network for sandbox \"f08820ced9f1c9a3d364c4eca7a0804a34b3722afa7cb8e7e1c121a852ae1547\": plugin type=\"calico\" failed (delete): error getting ClusterInformation: Get \"https://10.96.0.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default\": dial tcp 10.96.0.1:443: connect: connection refused"
: exit status 1, failed to stop running pod bb1e8949d19607a54bedcba8201b3961eb85e033cf850de573579caf41b1df31: output: E0407 02:30:55.663697  314225 remote_runtime.go:205] "StopPodSandbox from runtime service failed" err="rpc error: code = Unknown desc = failed to destroy network for sandbox \"bb1e8949d19607a54bedcba8201b3961eb85e033cf850de573579caf41b1df31\": plugin type=\"calico\" failed (delete): error getting ClusterInformation: Get \"https://10.96.0.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default\": dial tcp 10.96.0.1:443: connect: connection refused" podSandboxID="bb1e8949d19607a54bedcba8201b3961eb85e033cf850de573579caf41b1df31"
time="2023-04-07T02:30:55Z" level=fatal msg="stopping the pod sandbox \"bb1e8949d19607a54bedcba8201b3961eb85e033cf850de573579caf41b1df31\": rpc error: code = Unknown desc = failed to destroy network for sandbox \"bb1e8949d19607a54bedcba8201b3961eb85e033cf850de573579caf41b1df31\": plugin type=\"calico\" failed (delete): error getting ClusterInformation: Get \"https://10.96.0.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default\": dial tcp 10.96.0.1:443: connect: connection refused"
: exit status 1, failed to stop running pod 610566e483b6bb6e295650ab4f829fa061369e8fa492aefb99875e6200f8006d: output: E0407 02:30:56.050784  314439 remote_runtime.go:205] "StopPodSandbox from runtime service failed" err="rpc error: code = Unknown desc = failed to destroy network for sandbox \"610566e483b6bb6e295650ab4f829fa061369e8fa492aefb99875e6200f8006d\": plugin type=\"calico\" failed (delete): error getting ClusterInformation: Get \"https://10.96.0.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default\": dial tcp 10.96.0.1:443: connect: connection refused" podSandboxID="610566e483b6bb6e295650ab4f829fa061369e8fa492aefb99875e6200f8006d"
time="2023-04-07T02:30:56Z" level=fatal msg="stopping the pod sandbox \"610566e483b6bb6e295650ab4f829fa061369e8fa492aefb99875e6200f8006d\": rpc error: code = Unknown desc = failed to destroy network for sandbox \"610566e483b6bb6e295650ab4f829fa061369e8fa492aefb99875e6200f8006d\": plugin type=\"calico\" failed (delete): error getting ClusterInformation: Get \"https://10.96.0.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default\": dial tcp 10.96.0.1:443: connect: connection refused"
: exit status 1, failed to stop running pod 724f778e87e65abb9975a04aba566e0c058f4fc5dae173650e8ea2fa6ec56ac7: output: E0407 02:30:56.434430  314654 remote_runtime.go:205] "StopPodSandbox from runtime service failed" err="rpc error: code = Unknown desc = failed to destroy network for sandbox \"724f778e87e65abb9975a04aba566e0c058f4fc5dae173650e8ea2fa6ec56ac7\": plugin type=\"calico\" failed (delete): error getting ClusterInformation: Get \"https://10.96.0.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default\": dial tcp 10.96.0.1:443: connect: connection refused" podSandboxID="724f778e87e65abb9975a04aba566e0c058f4fc5dae173650e8ea2fa6ec56ac7"
time="2023-04-07T02:30:56Z" level=fatal msg="stopping the pod sandbox \"724f778e87e65abb9975a04aba566e0c058f4fc5dae173650e8ea2fa6ec56ac7\": rpc error: code = Unknown desc = failed to destroy network for sandbox \"724f778e87e65abb9975a04aba566e0c058f4fc5dae173650e8ea2fa6ec56ac7\": plugin type=\"calico\" failed (delete): error getting ClusterInformation: Get \"https://10.96.0.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default\": dial tcp 10.96.0.1:443: connect: connection refused"
: exit status 1, failed to stop running pod 47f55663a59c7e2609ff48d99aae35fe313fd6aa1cdc55b0a07306a842289cdf: output: E0407 02:30:56.815028  314872 remote_runtime.go:205] "StopPodSandbox from runtime service failed" err="rpc error: code = Unknown desc = failed to destroy network for sandbox \"47f55663a59c7e2609ff48d99aae35fe313fd6aa1cdc55b0a07306a842289cdf\": plugin type=\"calico\" failed (delete): error getting ClusterInformation: Get \"https://10.96.0.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default\": dial tcp 10.96.0.1:443: connect: connection refused" podSandboxID="47f55663a59c7e2609ff48d99aae35fe313fd6aa1cdc55b0a07306a842289cdf"
time="2023-04-07T02:30:56Z" level=fatal msg="stopping the pod sandbox \"47f55663a59c7e2609ff48d99aae35fe313fd6aa1cdc55b0a07306a842289cdf\": rpc error: code = Unknown desc = failed to destroy network for sandbox \"47f55663a59c7e2609ff48d99aae35fe313fd6aa1cdc55b0a07306a842289cdf\": plugin type=\"calico\" failed (delete): error getting ClusterInformation: Get \"https://10.96.0.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default\": dial tcp 10.96.0.1:443: connect: connection refused"
: exit status 1, failed to stop running pod 15e90d7660cb54696e0bd0420ef2c52f75bebe8c438050e1961970ba3ab58ea4: output: E0407 02:30:57.198718  315084 remote_runtime.go:205] "StopPodSandbox from runtime service failed" err="rpc error: code = Unknown desc = failed to destroy network for sandbox \"15e90d7660cb54696e0bd0420ef2c52f75bebe8c438050e1961970ba3ab58ea4\": plugin type=\"calico\" failed (delete): error getting ClusterInformation: Get \"https://10.96.0.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default\": dial tcp 10.96.0.1:443: connect: connection refused" podSandboxID="15e90d7660cb54696e0bd0420ef2c52f75bebe8c438050e1961970ba3ab58ea4"
time="2023-04-07T02:30:57Z" level=fatal msg="stopping the pod sandbox \"15e90d7660cb54696e0bd0420ef2c52f75bebe8c438050e1961970ba3ab58ea4\": rpc error: code = Unknown desc = failed to destroy network for sandbox \"15e90d7660cb54696e0bd0420ef2c52f75bebe8c438050e1961970ba3ab58ea4\": plugin type=\"calico\" failed (delete): error getting ClusterInformation: Get \"https://10.96.0.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default\": dial tcp 10.96.0.1:443: connect: connection refused"
: exit status 1, failed to stop running pod 072cd146567250c9c1d95de6599e830e6d7f9fc3a27f5f0b751b6c6f3440e4d1: output: E0407 02:30:57.579440  315298 remote_runtime.go:205] "StopPodSandbox from runtime service failed" err="rpc error: code = Unknown desc = failed to destroy network for sandbox \"072cd146567250c9c1d95de6599e830e6d7f9fc3a27f5f0b751b6c6f3440e4d1\": plugin type=\"calico\" failed (delete): error getting ClusterInformation: Get \"https://10.96.0.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default\": dial tcp 10.96.0.1:443: connect: connection refused" podSandboxID="072cd146567250c9c1d95de6599e830e6d7f9fc3a27f5f0b751b6c6f3440e4d1"
time="2023-04-07T02:30:57Z" level=fatal msg="stopping the pod sandbox \"072cd146567250c9c1d95de6599e830e6d7f9fc3a27f5f0b751b6c6f3440e4d1\": rpc error: code = Unknown desc = failed to destroy network for sandbox \"072cd146567250c9c1d95de6599e830e6d7f9fc3a27f5f0b751b6c6f3440e4d1\": plugin type=\"calico\" failed (delete): error getting ClusterInformation: Get \"https://10.96.0.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default\": dial tcp 10.96.0.1:443: connect: connection refused"
: exit status 1, failed to stop running pod 2aa6a9551835d1ffed125cccb3b854d6f9a9085ee2fec9615289ca19daaa3d55: output: E0407 02:30:57.959676  315517 remote_runtime.go:205] "StopPodSandbox from runtime service failed" err="rpc error: code = Unknown desc = failed to destroy network for sandbox \"2aa6a9551835d1ffed125cccb3b854d6f9a9085ee2fec9615289ca19daaa3d55\": plugin type=\"calico\" failed (delete): error getting ClusterInformation: Get \"https://10.96.0.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default\": dial tcp 10.96.0.1:443: connect: connection refused" podSandboxID="2aa6a9551835d1ffed125cccb3b854d6f9a9085ee2fec9615289ca19daaa3d55"
time="2023-04-07T02:30:57Z" level=fatal msg="stopping the pod sandbox \"2aa6a9551835d1ffed125cccb3b854d6f9a9085ee2fec9615289ca19daaa3d55\": rpc error: code = Unknown desc = failed to destroy network for sandbox \"2aa6a9551835d1ffed125cccb3b854d6f9a9085ee2fec9615289ca19daaa3d55\": plugin type=\"calico\" failed (delete): error getting ClusterInformation: Get \"https://10.96.0.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default\": dial tcp 10.96.0.1:443: connect: connection refused"
: exit status 1, failed to stop running pod 99dce2afebc075610d80abb505325ada323854ee9428abb0e5ad16f75af0d149: output: E0407 02:30:58.348787  315739 remote_runtime.go:205] "StopPodSandbox from runtime service failed" err="rpc error: code = Unknown desc = failed to destroy network for sandbox \"99dce2afebc075610d80abb505325ada323854ee9428abb0e5ad16f75af0d149\": plugin type=\"calico\" failed (delete): error getting ClusterInformation: Get \"https://10.96.0.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default\": dial tcp 10.96.0.1:443: connect: connection refused" podSandboxID="99dce2afebc075610d80abb505325ada323854ee9428abb0e5ad16f75af0d149"
time="2023-04-07T02:30:58Z" level=fatal msg="stopping the pod sandbox \"99dce2afebc075610d80abb505325ada323854ee9428abb0e5ad16f75af0d149\": rpc error: code = Unknown desc = failed to destroy network for sandbox \"99dce2afebc075610d80abb505325ada323854ee9428abb0e5ad16f75af0d149\": plugin type=\"calico\" failed (delete): error getting ClusterInformation: Get \"https://10.96.0.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default\": dial tcp 10.96.0.1:443: connect: connection refused"
: exit status 1]
[reset] Deleting contents of directories: [/etc/kubernetes/manifests /var/lib/kubelet /etc/kubernetes/pki]
[reset] Deleting files: [/etc/kubernetes/admin.conf /etc/kubernetes/kubelet.conf /etc/kubernetes/bootstrap-kubelet.conf /etc/kubernetes/controller-manager.conf /etc/kubernetes/scheduler.conf]

The reset process does not clean CNI configuration. To do so, you must remove /etc/cni/net.d

The reset process does not reset or clean up iptables rules or IPVS tables.
If you wish to reset iptables, you must do so manually by using the "iptables" command.

If your cluster was setup to utilize IPVS, run ipvsadm --clear (or similar)
to reset your system's IPVS tables.

The reset process does not clean your kubeconfig files and you must remove them manually.
Please, check the contents of the $HOME/.kube/config file.
```

#### :round_pushpin: https://stackoverflow.com/questions/51169728/failed-create-pod-sandbox-rpc-error-code-unknown-desc-networkplugin-cni-fa

| repertoire   | fonction |
|--------------|----------|
| /etc/cni     | net.d    |
| /opt/cni     | bin      |
| /var/lib/cni |          |


# References:

https://stackoverflow.com/questions/52390481/kubernetes-calico-node-xxxxxxxxxxx-already-using-ipv4-address-xxxxxxxxx-crash
