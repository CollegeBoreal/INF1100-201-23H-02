# Kube Tools

Sur chacun des serveurs, installer les outils suivants

## :zero: Preparer le serveur

Mettre le serveur à jour et le redémarrer.

:warning: Attention, le serveur va `reboot`er

```
sudo apt update && sudo apt -y upgrade && sudo systemctl reboot
```

## :one: Installer le [référentiel](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository) `google cloud`

:round_pushpin: Installe `curl`, `apt-transport-https` et autres outils utilisé pour télécharger les librairies (Package Manager)

:bulb: Certains référentiels ont des `URL` utilisant `HTTPS`. La librairie `apt-transport-https` doit être installée pour acceder le lien `HTTPS`:

```
sudo apt-get install -y apt-transport-https ca-certificates curl
```

:round_pushpin: Ajout du référentiel de librairies `kubernetes` au référentiel de gestionnaire de libraries  

- [ ] Ajout de la clé officielle `gpg` :key: de `google cloud` qui sera placé dan le fichier binaire `/etc/apt/keyrings/kubernetes-archive-keyring.gpg`

* Ajouter la clé `GPG` (GNU Privacy Guard)

```
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
```

- [ ] Ajouter le fichier `kubernetes debian` au référentiel

```
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" \
         | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

## :two: Installer **kubeadm** and **kubectl**

:bulb: Quels outils :ice_cube: kube doit on installer? 

| Outil   | Utilisation                                                      |
|---------|------------------------------------------------------------------|
| kubeadm | Outil créé pour fournir **kubeadm** `init` et **kubeadm** `join` |
| kubectl | Outil de ligne de commande Kubernetes                            |

:round_pushpin: Installer les outils :ice_cube: `kube`

- [ ] Choisir une version spécifique de Kubernetes

```
export KUBEVERSION=1.23.6
``` 

- [ ] Installer la version spécifique de Kubernetes

```
sudo apt update && sudo apt install -y kubeadm=${KUBEVERSION}-00 kubectl=${KUBEVERSION}-00
```

:round_pushpin: Prévenir l'altération (mise à jour) des outils :ice_cube: `kube`

```
sudo apt-mark hold kubeadm kubectl
```

:+1: Tester que les outils :ice_cube: `kube` sont installés

```
OUT="--output=json"; kubeadm version ${OUT} && kubectl version --client ${OUT}
```
> Retourne
```json
{
  "clientVersion": {
    "major": "1",
    "minor": "18",
    "gitVersion": "v1.18.6",
    "gitCommit": "dff82dc0de47299ab66c83c626e08b245ab19037",
    "gitTreeState": "clean",
    "buildDate": "2020-07-15T16:56:34Z",
    "goVersion": "go1.13.9",
    "compiler": "gc",
    "platform": "linux/amd64"
  }
}
{
  "clientVersion": {
    "major": "1",
    "minor": "18",
    "gitVersion": "v1.18.6",
    "gitCommit": "dff82dc0de47299ab66c83c626e08b245ab19037",
    "gitTreeState": "clean",
    "buildDate": "2020-07-15T16:58:53Z",
    "goVersion": "go1.13.9",
    "compiler": "gc",
    "platform": "linux/amd64"
  }
}
```

[:back:](../#round_pushpin-installation-des-outils)

# References

- [ ] [Installing kubeadm, kubelet and kubectl](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl)

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
