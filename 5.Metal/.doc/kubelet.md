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

## :one: Tout de suite après l'installation du service

:+1: Tester que le service `kubelet` est chargé **(loaded)**

```
$ systemctl status kubelet
● kubelet.service - kubelet: The Kubernetes Node Agent
     Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
    Drop-In: /etc/systemd/system/kubelet.service.d
             └─10-kubeadm.conf
     Active: activating (auto-restart) (Result: exit-code) since Sun 2021-02-14 11:30:15 UTC; 2s ago
       Docs: https://kubernetes.io/docs/home/
    Process: 315103 ExecStart=/usr/bin/kubelet $KUBELET_KUBECONFIG_ARGS $KUBELET_CONFIG_ARGS $KUBELET_KUBEADM_ARGS $KUBELET_EX>
   Main PID: 315103 (code=exited, status=255/EXCEPTION)
```

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
hi  kubelet        1.23.5-00    amd64        Kubernetes Node Agent
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
     export KUBEVERSION=1.18.6
     ``` 

     - [ ] reCommencer l'installation

     ```
     sudo apt -y install kubelet=${KUBEVERSION}-00 && sudo apt -y install kubeadm=${KUBEVERSION}-00
     ```
