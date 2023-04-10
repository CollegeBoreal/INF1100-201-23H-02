# :whale2: Installer le `CRI`  `containerd.io`

<img src='../../images/ContainerEcosystem.png width='' height='' > </img>

## :cl: Nettoyer

* Supprimer les anciens paquets (note: il n'y a pas de `.io`)

```
sudo apt remove containerd runc
```
> Retourne :
```yaml
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Package 'containerd' is not installed, so not removed
Package 'runc' is not installed, so not removed
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
```


## :a: [Install using the Docker apt repository](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)

:round_pushpin: Update the apt package index and install packages to allow apt to use a repository over HTTPS:

```
sudo apt-get update && sudo apt-get install ca-certificates curl gnupg
```
> Retourne :
```yaml
Hit:1 http://ports.ubuntu.com/ubuntu-ports jammy InRelease
Hit:3 http://ports.ubuntu.com/ubuntu-ports jammy-updates InRelease
Hit:4 http://ports.ubuntu.com/ubuntu-ports jammy-backports InRelease
Hit:5 http://ports.ubuntu.com/ubuntu-ports jammy-security InRelease               
Hit:2 https://packages.cloud.google.com/apt kubernetes-xenial InRelease           
Reading package lists... Done
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
ca-certificates is already the newest version (20211016ubuntu0.22.04.1).
curl is already the newest version (7.81.0-1ubuntu1.10).
gnupg is already the newest version (2.2.27-3ubuntu2.1).
gnupg set to manually installed.
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
```

:round_pushpin: Add Docker’s official GPG key:

```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

:bulb: check

* if doesn't exist create `sudo mkdir -m 0755 -p /etc/apt/keyrings`

```
file /etc/apt/keyrings/docker.gpg
```
> /etc/apt/keyrings/docker.gpg: OpenPGP Public Key Version 4, Created Wed Feb 22 18:36:26 2017, RSA (Encrypt or Sign, 4096 bits); User ID; Signature; OpenPGP Certificate


- [ ] Create the docker debian repository file

```
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

* Vérifier

```
cat /etc/apt/sources.list.d/docker.list
```
> deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu   jammy stable

* Mettre à jour 

```
sudo apt update
```
> Retourne 
```yaml
Hit:1 https://download.docker.com/linux/ubuntu jammy InRelease
Hit:2 http://ports.ubuntu.com/ubuntu-ports jammy InRelease
Hit:4 http://ports.ubuntu.com/ubuntu-ports jammy-updates InRelease
Hit:5 http://ports.ubuntu.com/ubuntu-ports jammy-backports InRelease
Hit:6 http://ports.ubuntu.com/ubuntu-ports jammy-security InRelease
Hit:3 https://packages.cloud.google.com/apt kubernetes-xenial InRelease
Reading package lists... Done                              
Building dependency tree... Done
Reading state information... Done
All packages are up to date.
```

## :b: Installer le paquet `containerd.io` 

- [ ] Installer

```
sudo apt install containerd.io
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


## :ab: Paramétrer le `CGROUP` pour `Systemd`

- [ ] Objectif: Régler le `cgroup` lié à `Systemd` [:bangbang: Issues with "stability" with Kubernetes cluster before adding networking](https://stackoverflow.com/questions/72567945/issues-with-stability-with-kubernetes-cluster-before-adding-networking/73743910#73743910)

:round_pushpin: Afficher le ficher de configuration `config.toml` à modifier

```
sudo cat /etc/containerd/config.toml
```
> Retourne :
```yaml
#   Copyright 2018-2022 Docker Inc.

#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at

#       http://www.apache.org/licenses/LICENSE-2.0

#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

disabled_plugins = ["cri"]

#root = "/var/lib/containerd"
#state = "/run/containerd"
#subreaper = true
#oom_score = 0

#[grpc]
#  address = "/run/containerd/containerd.sock"
#  uid = 0
#  gid = 0

#[debug]
#  address = "/run/containerd/debug.sock"
#  uid = 0
#  gid = 0
#  level = "info"
```

:round_pushpin: Configurer `containerd`

* Changer le fichier de configuration `/etc/containerd/config.toml` pour l'utilisation des `CGROUP`s avec `SystemD`

```
containerd config default | sudo tee /etc/containerd/config.toml
```

* Modifier le `CGroup` à `VRAI`

```
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
```

* Vérifier le `CGroup` à `VRAI`

```
sudo cat /etc/containerd/config.toml | grep SystemdCgroup
```
>            SystemdCgroup = true


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
     Active: active (running) since Mon 2023-04-10 00:07:29 UTC; 3s ago
       Docs: https://containerd.io
    Process: 5920 ExecStartPre=/sbin/modprobe overlay (code=exited, status=0/SUCCESS)
   Main PID: 5921 (containerd)
      Tasks: 10
     Memory: 12.8M
        CPU: 434ms
     CGroup: /system.slice/containerd.service
             └─5921 /usr/bin/containerd

Apr 10 00:07:29 rukbat containerd[5921]: time="2023-04-10T00:07:29.910108934Z" level=info msg="Start subscribing containerd event"
Apr 10 00:07:29 rukbat containerd[5921]: time="2023-04-10T00:07:29.910294341Z" level=info msg="Start recovering state"
Apr 10 00:07:29 rukbat containerd[5921]: time="2023-04-10T00:07:29.910714616Z" level=info msg="Start event monitor"
Apr 10 00:07:29 rukbat containerd[5921]: time="2023-04-10T00:07:29.910838060Z" level=info msg="Start snapshots syncer"
Apr 10 00:07:29 rukbat containerd[5921]: time="2023-04-10T00:07:29.910897170Z" level=info msg="Start cni network conf syncer for default"
Apr 10 00:07:29 rukbat containerd[5921]: time="2023-04-10T00:07:29.910942133Z" level=info msg="Start streaming server"
Apr 10 00:07:29 rukbat containerd[5921]: time="2023-04-10T00:07:29.911321816Z" level=info msg=serving... address=/run/containerd/containerd.soc>
Apr 10 00:07:29 rukbat containerd[5921]: time="2023-04-10T00:07:29.911702962Z" level=info msg=serving... address=/run/containerd/containerd.sock
Apr 10 00:07:29 rukbat systemd[1]: Started containerd container runtime.
Apr 10 00:07:29 rukbat containerd[5921]: time="2023-04-10T00:07:29.915907602Z" level=info msg="containerd successfully booted in 0.186967s"
```

* taper sur `q` pour quitter

## :warning: Rebooter la machine

```
sudo reboot -n now
```

## [:back:](../#round_pushpin-installation-des-services)

# References

- [ ] [Updated: Dockershim Removal FAQ](https://kubernetes.io/blog/2022/02/17/dockershim-faq/)
- [ ] [How to Install Containerd on Ubuntu 22.04 / Ubuntu 20.04](https://www.itzgeek.com/how-tos/linux/ubuntu-how-tos/install-containerd-on-ubuntu-22-04.html)
- [ ] [Configuring the systemd cgroup driver](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#containerd-systemd)
- [ ] [if not add "version = 2" to the /etc/containerd/config.toml, some configuration will be ingored](https://github.com/containerd/containerd/issues/5237)

```
containerd --version
```
> containerd containerd.io 1.6.20 2806fc1057397dbaeefbea0e4e17bddfbd388f38


```
runc --version
```
```yaml
runc version 1.1.5
commit: v1.1.5-0-gf19387a
spec: 1.0.2-dev
go: go1.19.7
libseccomp: 2.5.3
```

:round_pushpin: FIX `crictl` [Container List Issue](https://forum.linuxfoundation.org/discussion/861469/containerd-list-of-containers)

```
sudo crictl info
```
```yaml
WARN[0000] runtime connect using default endpoints: [unix:///var/run/dockershim.sock unix:///run/containerd/containerd.sock unix:///run/crio/crio.sock unix:///var/run/cri-dockerd.sock]. As the default settings are now deprecated, you should set the endpoint instead. 
E0409 21:53:28.499719   14181 remote_runtime.go:616] "Status from runtime service failed" err="rpc error: code = Unavailable desc = connection error: desc = \"transport: Error while dialing dial unix /var/run/dockershim.sock: connect: no such file or directory\""
FATA[0000] getting status of runtime: rpc error: code = Unavailable desc = connection error: desc = "transport: Error while dialing dial unix /var/run/dockershim.sock: connect: no such file or directory" 
```



```
sudo crictl config --set runtime-endpoint=unix:///run/containerd/containerd.sock --set image-endpoint=unix:///run/containerd/containerd.sock
```

```
sudo cat /etc/crictl.yaml
```
```yaml
runtime-endpoint: "unix:///run/containerd/containerd.sock"
image-endpoint: "unix:///run/containerd/containerd.sock"
timeout: 0
debug: false
pull-image-on-create: false
disable-pull-on-run: false
```

```
sudo crictl info
```
```json
{
  "status": {
    "conditions": [
      {
        "type": "RuntimeReady",
        "status": true,
        "reason": "",
        "message": ""
      },
      {
        "type": "NetworkReady",
        "status": false,
        "reason": "NetworkPluginNotReady",
        "message": "Network plugin returns error: cni plugin not initialized"
      }
    ]
  },
  "cniconfig": {
    "PluginDirs": [
      "/opt/cni/bin"
    ],
    "PluginConfDir": "/etc/cni/net.d",
    "PluginMaxConfNum": 1,
    "Prefix": "eth",
    "Networks": [
      {
        "Config": {
          "Name": "cni-loopback",
          "CNIVersion": "0.3.1",
          "Plugins": [
            {
              "Network": {
                "type": "loopback",
                "ipam": {},
                "dns": {}
              },
              "Source": "{\"type\":\"loopback\"}"
            }
          ],
          "Source": "{\n\"cniVersion\": \"0.3.1\",\n\"name\": \"cni-loopback\",\n\"plugins\": [{\n  \"type\": \"loopback\"\n}]\n}"
        },
        "IFName": "lo"
      }
    ]
  },
  "config": {
    "containerd": {
      "snapshotter": "overlayfs",
      "defaultRuntimeName": "runc",
      "defaultRuntime": {
        "runtimeType": "",
        "runtimePath": "",
        "runtimeEngine": "",
        "PodAnnotations": [],
        "ContainerAnnotations": [],
        "runtimeRoot": "",
        "options": {},
        "privileged_without_host_devices": false,
        "baseRuntimeSpec": "",
        "cniConfDir": "",
        "cniMaxConfNum": 0
      },
      "untrustedWorkloadRuntime": {
        "runtimeType": "",
        "runtimePath": "",
        "runtimeEngine": "",
        "PodAnnotations": [],
        "ContainerAnnotations": [],
        "runtimeRoot": "",
        "options": {},
        "privileged_without_host_devices": false,
        "baseRuntimeSpec": "",
        "cniConfDir": "",
        "cniMaxConfNum": 0
      },
      "runtimes": {
        "runc": {
          "runtimeType": "io.containerd.runc.v2",
          "runtimePath": "",
          "runtimeEngine": "",
          "PodAnnotations": [],
          "ContainerAnnotations": [],
          "runtimeRoot": "",
          "options": {
            "BinaryName": "",
            "CriuImagePath": "",
            "CriuPath": "",
            "CriuWorkPath": "",
            "IoGid": 0,
            "IoUid": 0,
            "NoNewKeyring": false,
            "NoPivotRoot": false,
            "Root": "",
            "ShimCgroup": "",
            "SystemdCgroup": true
          },
          "privileged_without_host_devices": false,
          "baseRuntimeSpec": "",
          "cniConfDir": "",
          "cniMaxConfNum": 0
        }
      },
      "noPivot": false,
      "disableSnapshotAnnotations": true,
      "discardUnpackedLayers": false,
      "ignoreRdtNotEnabledErrors": false
    },
    "cni": {
      "binDir": "/opt/cni/bin",
      "confDir": "/etc/cni/net.d",
      "maxConfNum": 1,
      "confTemplate": "",
      "ipPref": ""
    },
    "registry": {
      "configPath": "",
      "mirrors": {},
      "configs": {},
      "auths": {},
      "headers": {}
    },
    "imageDecryption": {
      "keyModel": "node"
    },
    "disableTCPService": true,
    "streamServerAddress": "127.0.0.1",
    "streamServerPort": "0",
    "streamIdleTimeout": "4h0m0s",
    "enableSelinux": false,
    "selinuxCategoryRange": 1024,
    "sandboxImage": "registry.k8s.io/pause:3.6",
    "statsCollectPeriod": 10,
    "systemdCgroup": false,
    "enableTLSStreaming": false,
    "x509KeyPairStreaming": {
      "tlsCertFile": "",
      "tlsKeyFile": ""
    },
    "maxContainerLogSize": 16384,
    "disableCgroup": false,
    "disableApparmor": false,
    "restrictOOMScoreAdj": false,
    "maxConcurrentDownloads": 3,
    "disableProcMount": false,
    "unsetSeccompProfile": "",
    "tolerateMissingHugetlbController": true,
    "disableHugetlbController": true,
    "device_ownership_from_security_context": false,
    "ignoreImageDefinedVolumes": false,
    "netnsMountsUnderStateDir": false,
    "enableUnprivilegedPorts": false,
    "enableUnprivilegedICMP": false,
    "containerdRootDir": "/var/lib/containerd",
    "containerdEndpoint": "/run/containerd/containerd.sock",
    "rootDir": "/var/lib/containerd/io.containerd.grpc.v1.cri",
    "stateDir": "/run/containerd/io.containerd.grpc.v1.cri"
  },
  "golang": "go1.19.7",
  "lastCNILoadStatus": "cni config load failed: no network config found in /etc/cni/net.d: cni plugin not initialized: failed to load cni config",
  "lastCNILoadStatus.default": "cni config load failed: no network config found in /etc/cni/net.d: cni plugin not initialized: failed to load cni config"
}
```
