# Kube Tools

Sur chacun des serveurs, installer les outils suivants

## :zero: Preparer le serveur

Mettre le serveur à jour et le redémarrer.

:warning: Attention, le serveur va `reboot`er

```
sudo apt update && sudo apt -y upgrade && sudo systemctl reboot
```

## :one: Installer le [référentiel](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management) `google cloud`

:round_pushpin: Installer `curl`, `apt-transport-https` et autres outils utilisés pour télécharger les librairies (Package Manager)

:bulb: Certains référentiels ont des `URL` utilisant `HTTPS`. La librairie `apt-transport-https` doit être installée pour acceder le lien `HTTPS`:

```
sudo apt-get install -y apt-transport-https ca-certificates curl
```

:round_pushpin: Ajout du référentiel de librairies `kubernetes` au référentiel de gestionnaire de libraries  

- [ ] Ajout de la clé officielle `gpg` :key: de `google cloud`  `GPG` (GNU Privacy Guard)
      
* placée dans le fichier `binaire` :grey_exclamation: `/etc/apt/keyrings/kubernetes-archive-keyring.gpg`
* en tapant la commande

```
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
```

* Vérification de la clé :key: `GPG`

```
file /etc/apt/keyrings/kubernetes-archive-keyring.gpg
```
> /etc/apt/keyrings/kubernetes-archive-keyring.gpg: OpenPGP Public Key Version 4, Created Sat May 21 09:50:12 2022, RSA (Encrypt or Sign, 2048 bits); User ID; Signature; OpenPGP Certificate

- [ ] Ajouter le fichier `kubernetes debian` au référentiel `apt`

```
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" \
         | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

- [ ] Vérifier le contenu du fichier

```
cat /etc/apt/sources.list.d/kubernetes.list
```
> Retourne :
<pre> 
deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main
</pre>

## :two: Installer **kubeadm** and **kubectl**

:bulb: Quels outils :ice_cube: kube doit on installer? 

| Outil   | Utilisation                                                      |
|---------|------------------------------------------------------------------|
| kubeadm | Outil créé pour fournir **kubeadm** `init` et **kubeadm** `join` |
| kubectl | Outil de ligne de commande Kubernetes                            |

:round_pushpin: Installer les outils :ice_cube: `kube`

- [ ] Choisir une version spécifique de Kubernetes

```
export KUBEVERSION=1.26.3
``` 

- [ ] Installer la version spécifique de Kubernetes

```
sudo apt update && sudo apt install -y kubeadm=${KUBEVERSION}-00 kubectl=${KUBEVERSION}-00
```
> Retourne :
<pre>
Hit:1 http://ca.archive.ubuntu.com/ubuntu jammy InRelease
Get:2 https://download.docker.com/linux/ubuntu focal InRelease [57.7 kB]  
Get:3 http://ca.archive.ubuntu.com/ubuntu jammy-updates InRelease [119 kB]     
Get:5 http://ca.archive.ubuntu.com/ubuntu jammy-backports InRelease [108 kB]   
Get:6 http://ca.archive.ubuntu.com/ubuntu jammy-security InRelease [110 kB]    
Get:7 http://ca.archive.ubuntu.com/ubuntu jammy-updates/main amd64 Packages [990 kB]
Get:4 https://packages.cloud.google.com/apt kubernetes-xenial InRelease [8,993 B]
Get:8 http://ca.archive.ubuntu.com/ubuntu jammy-updates/restricted amd64 Packages [744 kB]
Get:9 http://ca.archive.ubuntu.com/ubuntu jammy-updates/restricted amd64 c-n-f Metadata [576 B]
Get:10 http://ca.archive.ubuntu.com/ubuntu jammy-updates/universe amd64 Packages [899 kB]
Get:11 http://ca.archive.ubuntu.com/ubuntu jammy-updates/universe Translation-en [180 kB]
Get:12 http://ca.archive.ubuntu.com/ubuntu jammy-updates/universe amd64 c-n-f Metadata [18.6 kB]
Get:13 http://ca.archive.ubuntu.com/ubuntu jammy-updates/multiverse amd64 Packages [24.1 kB]
Get:14 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 Packages [64.5 kB]
Get:15 http://ca.archive.ubuntu.com/ubuntu jammy-updates/multiverse amd64 c-n-f Metadata [444 B]
Fetched 3,324 kB in 1s (2,748 kB/s)                            
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
5 packages can be upgraded. Run 'apt list --upgradable' to see them.
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  conntrack cri-tools ebtables kubelet kubernetes-cni socat
The following NEW packages will be installed:
  conntrack cri-tools ebtables kubeadm kubectl kubelet kubernetes-cni socat
0 upgraded, 8 newly installed, 0 to remove and 5 not upgraded.
Need to get 87.3 MB of archives.
After this operation, 341 MB of additional disk space will be used.
Get:1 http://ca.archive.ubuntu.com/ubuntu jammy/main amd64 conntrack amd64 1:1.4.6-2build2 [33.5 kB]
Get:5 http://ca.archive.ubuntu.com/ubuntu jammy/main amd64 ebtables amd64 2.0.11-4build2 [84.9 kB]
Get:8 http://ca.archive.ubuntu.com/ubuntu jammy/main amd64 socat amd64 1.7.4.1-3ubuntu4 [349 kB]
Get:2 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 cri-tools amd64 1.26.0-00 [18.9 MB]
Get:3 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubernetes-cni amd64 1.2.0-00 [27.6 MB]
Get:4 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubelet amd64 1.26.3-00 [20.5 MB]
Get:6 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubectl amd64 1.26.3-00 [10.1 MB]
Get:7 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubeadm amd64 1.26.3-00 [9,747 kB]     
Fetched 87.3 MB in 7s (11.9 MB/s)                                                                               
Selecting previously unselected package conntrack.
(Reading database ... 75969 files and directories currently installed.)
Preparing to unpack .../0-conntrack_1%3a1.4.6-2build2_amd64.deb ...
Unpacking conntrack (1:1.4.6-2build2) ...
Selecting previously unselected package cri-tools.
Preparing to unpack .../1-cri-tools_1.26.0-00_amd64.deb ...
Unpacking cri-tools (1.26.0-00) ...
Selecting previously unselected package ebtables.
Preparing to unpack .../2-ebtables_2.0.11-4build2_amd64.deb ...
Unpacking ebtables (2.0.11-4build2) ...
Selecting previously unselected package kubernetes-cni.
Preparing to unpack .../3-kubernetes-cni_1.2.0-00_amd64.deb ...
Unpacking kubernetes-cni (1.2.0-00) ...
Selecting previously unselected package socat.
Preparing to unpack .../4-socat_1.7.4.1-3ubuntu4_amd64.deb ...
Unpacking socat (1.7.4.1-3ubuntu4) ...
Selecting previously unselected package kubelet.
Preparing to unpack .../5-kubelet_1.26.3-00_amd64.deb ...
Unpacking kubelet (1.26.3-00) ...
Selecting previously unselected package kubectl.
Preparing to unpack .../6-kubectl_1.26.3-00_amd64.deb ...
Unpacking kubectl (1.26.3-00) ...
Selecting previously unselected package kubeadm.
Preparing to unpack .../7-kubeadm_1.26.3-00_amd64.deb ...
Unpacking kubeadm (1.26.3-00) ...
Setting up conntrack (1:1.4.6-2build2) ...
Setting up kubectl (1.26.3-00) ...
Setting up ebtables (2.0.11-4build2) ...
Setting up socat (1.7.4.1-3ubuntu4) ...
Setting up cri-tools (1.26.0-00) ...
Setting up kubernetes-cni (1.2.0-00) ...
Setting up kubelet (1.26.3-00) ...
Created symlink /etc/systemd/system/multi-user.target.wants/kubelet.service → /lib/systemd/system/kubelet.service.
Setting up kubeadm (1.26.3-00) ...
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
</pre>

:round_pushpin: Prévenir l'altération (mise à jour) des outils :ice_cube: `kube`

```
sudo apt-mark hold kubeadm kubectl
```
> Retourne :
<pre>
kubeadm set on hold.
kubectl set on hold.
</pre>

:+1: Tester que les outils :ice_cube: `kube` sont installés

```
OUT="--output=json"; kubeadm version ${OUT} && kubectl version --client ${OUT}
```
> Retourne
```json
{
  "clientVersion": {
    "major": "1",
    "minor": "26",
    "gitVersion": "v1.26.3",
    "gitCommit": "9e644106593f3f4aa98f8a84b23db5fa378900bd",
    "gitTreeState": "clean",
    "buildDate": "2023-03-15T13:38:47Z",
    "goVersion": "go1.19.7",
    "compiler": "gc",
    "platform": "linux/amd64"
  }
}
{
  "clientVersion": {
    "major": "1",
    "minor": "26",
    "gitVersion": "v1.26.3",
    "gitCommit": "9e644106593f3f4aa98f8a84b23db5fa378900bd",
    "gitTreeState": "clean",
    "buildDate": "2023-03-15T13:40:17Z",
    "goVersion": "go1.19.7",
    "compiler": "gc",
    "platform": "linux/amd64"
  },
  "kustomizeVersion": "v4.5.7"
}
```

## [:back:](../#round_pushpin-installation-des-outils)

# References

- [ ] [Installing kubeadm, kubelet and kubectl](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl)
