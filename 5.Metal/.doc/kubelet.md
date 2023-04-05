#  :droplet: kubelet

| Service | Utilisation                                                   |
|---------|--------------------------------------------------------------------------------------------------------------------------|
| kubelet | Responsable de maintainir un ensemble de `pods`, qui sont composés d'un ou de plusieurs conteneurs, dans un système local |

## :zero: Installer la librairie

:bulb: S'assurer que le référentiel des librairies `kubernetes` a été installé précédemment (voir [Installation des outils kubernetes](kube-tools.md#one-installer-le-référentiel-google-cloud))

:round_pushpin: Installer la librairie du service `kubelet`

- [ ] Choisir une version spécifique de Kubernetes

```
export KUBEVERSION=1.26.3
``` 

- [ ] Commencer l'installation

```
sudo apt update && sudo apt -y install kubelet=${KUBEVERSION}-00
```

:round_pushpin:  Prévenir l'altération (mise à jour) du service :droplet: kubelet

```
sudo apt-mark hold kubelet
```


## :gear: Où est le fichier de service `kubelet` [drop-in file](https://stackoverflow.com/questions/59842743/what-is-a-drop-in-file-what-is-a-drop-in-directory-how-to-edit-systemd-service) (i.e. fichier systemd .conf)

```
sudo cat /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
```
> Retourne
<pre>
# Note: This dropin only works with kubeadm and kubelet v1.11+
[Service]
Environment="KUBELET_KUBECONFIG_ARGS=--bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf"
Environment="KUBELET_CONFIG_ARGS=--config=/var/lib/kubelet/config.yaml"
# This is a file that "kubeadm init" and "kubeadm join" generates at runtime, populating the KUBELET_KUBEADM_ARGS variable dynamically
EnvironmentFile=-/var/lib/kubelet/kubeadm-flags.env
# This is a file that the user can use for overrides of the kubelet args as a last resort. Preferably, the user should use
# the .NodeRegistration.KubeletExtraArgs object in the configuration files instead. KUBELET_EXTRA_ARGS should be sourced from this file.
EnvironmentFile=-/etc/default/kubelet
ExecStart=
ExecStart=/usr/bin/kubelet $KUBELET_KUBECONFIG_ARGS $KUBELET_CONFIG_ARGS $KUBELET_KUBEADM_ARGS $KUBELET_EXTRA_ARGS
</pre>

## :one: Tout de suite après l'installation du service

:+1: Tester que le service `kubelet` est chargé **(loaded)**

```
$ systemctl status kubelet
```
> Retourne
<pre>
● kubelet.service - kubelet: The Kubernetes Node Agent
     Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
    Drop-In: /etc/systemd/system/kubelet.service.d
             └─10-kubeadm.conf
     Active: activating (auto-restart) (Result: exit-code) since Fri 2023-03-31 20:46:50 UTC; 6s ago
       Docs: https://kubernetes.io/docs/home/
    Process: 12069 ExecStart=/usr/bin/kubelet $KUBELET_KUBECONFIG_ARGS $KUBELET_CONFIG_ARGS $KUBELET_KUBEADM_ARGS $KUBELET_EXTRA_ARGS (code=exited, >
   Main PID: 12069 (code=exited, status=1/FAILURE)
        CPU: 138ms
lines 1-9/9 (END)
</pre>

:bulb: Appuyer sur `q` pour quitter

## :two: Démarrer le :droplet: service `kubelet`

``` 
sudo systemctl enable kubelet && sudo systemctl start kubelet
```

:warning: Le service `kubelet` ne sera disponible qu'après l'initialisation de la grappe `kubeadm init`

[:back:](../#round_pushpin-installation-des-services)

# Références

https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/kubelet-integration/


# :x: Troubleshooting

:one: Si vous vous êtes trompé de version 

- [ ] vérifier la version installée

```
sudo dpkg --list kubelet
```
> Retourne
```
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name           Version      Architecture Description
+++-==============-============-============-=================================
ii  kubelet        1.26.3-00    amd64        Kubernetes Node Agent
```

- [ ] Si ce n'est pas la bonne version, 

  - [ ] enlever le marquage

     ```
     sudo apt-mark unhold kubelet kubeadm
     ```

   - [ ] enlever la librairie

     ```
     sudo apt purge kubelet
     ```

:bulb: Si une librarie en dépend, désinstaller la (i.e. `kubeadm`)

- [ ] Réinstaller la librairie avec la bonne version

     - [ ] Choisir une version spécifique de Kubernetes

     ```
     export KUBEVERSION=1.26.3
     ``` 

     - [ ] reCommencer l'installation (incluant kubeadm)

     ```
     sudo apt -y install kubelet=${KUBEVERSION}-00 && sudo apt -y install kubeadm=${KUBEVERSION}-00
     ```
