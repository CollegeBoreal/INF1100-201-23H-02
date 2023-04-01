# Docker :whale:


:x: Uninstall old versions

Older versions of Docker went by the names of `docker`, `docker.io`, or `docker-engine`, you might also have installations of `containerd` or `runc`. Uninstall any such older versions before attempting to install a new version:

```
sudo apt-get remove docker docker-engine docker.io containerd runc
```

## :gear: Installation methods

You can install Docker Engine in different ways, depending on your needs:


* Set up and install Docker Engine from [Docker’s `apt` repository](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository).

* Use a [convenience scripts](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script). Only recommended for testing and development environments.

## :a: [Install using the apt repository](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)

:round_pushpin: Update the apt package index and install packages to allow apt to use a repository over HTTPS:

```
sudo apt-get update && sudo apt-get install ca-certificates curl gnupg
```

:round_pushpin: Add Docker’s official GPG key:

```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

:bulb: if doesn't exist create `sudo mkdir -m 0755 -p /etc/apt/keyrings`


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
sudo apt-get update
```
> Retourne 
<pre>
Hit:1 http://ca.archive.ubuntu.com/ubuntu jammy InRelease
Get:2 https://download.docker.com/linux/ubuntu jammy InRelease [48.9 kB]   
Hit:3 http://ca.archive.ubuntu.com/ubuntu jammy-updates InRelease                                            
Get:4 http://ca.archive.ubuntu.com/ubuntu jammy-backports InRelease [108 kB]
Get:6 http://ca.archive.ubuntu.com/ubuntu jammy-security InRelease [110 kB]
Get:7 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages [14.7 kB]        
Hit:5 https://packages.cloud.google.com/apt kubernetes-xenial InRelease                      
Fetched 282 kB in 1s (371 kB/s)
Reading package lists... Done
W: Target Packages (stable/binary-amd64/Packages) is configured multiple times in /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-jammy.list:1 and /etc/apt/sources.list.d/docker.list:1
W: Target Packages (stable/binary-all/Packages) is configured multiple times in /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-jammy.list:1 and /etc/apt/sources.list.d/docker.list:1
W: Target Translations (stable/i18n/Translation-en_US) is configured multiple times in /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-jammy.list:1 and /etc/apt/sources.list.d/docker.list:1
W: Target Translations (stable/i18n/Translation-en) is configured multiple times in /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-jammy.list:1 and /etc/apt/sources.list.d/docker.list:1
W: Target CNF (stable/cnf/Commands-amd64) is configured multiple times in /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-jammy.list:1 and /etc/apt/sources.list.d/docker.list:1
W: Target CNF (stable/cnf/Commands-all) is configured multiple times in /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-jammy.list:1 and /etc/apt/sources.list.d/docker.list:1
W: Target Packages (stable/binary-amd64/Packages) is configured multiple times in /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-jammy.list:1 and /etc/apt/sources.list.d/docker.list:1
W: Target Packages (stable/binary-all/Packages) is configured multiple times in /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-jammy.list:1 and /etc/apt/sources.list.d/docker.list:1
W: Target Translations (stable/i18n/Translation-en_US) is configured multiple times in /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-jammy.list:1 and /etc/apt/sources.list.d/docker.list:1
W: Target Translations (stable/i18n/Translation-en) is configured multiple times in /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-jammy.list:1 and /etc/apt/sources.list.d/docker.list:1
W: Target CNF (stable/cnf/Commands-amd64) is configured multiple times in /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-jammy.list:1 and /etc/apt/sources.list.d/docker.list:1
W: Target CNF (stable/cnf/Commands-all) is configured multiple times in /etc/apt/sources.list.d/archive_uri-https_download_docker_com_linux_ubuntu-jammy.list:1 and /etc/apt/sources.list.d/docker.list:1
</pre>

:round_pushpin: Installer le :whale: moteur `Docker`

- [ ] Choisir une version spécifique

```
VERSION_STRING=5:23.0.2-1~ubuntu.22.04~jammy
```

- [ ] Procéder à l'installation

```
sudo apt-get install docker-ce=$VERSION_STRING docker-ce-cli=$VERSION_STRING containerd.io docker-buildx-plugin docker-compose-plugin
```

- [ ] Vérifier que le service est actif

```
systemctl status docker
```
> Retourne :
<pre>
systemctl status docker
● docker.service - Docker Application Container Engine
     Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset>
     Active: active (running) since Fri 2023-03-31 23:23:53 UTC; 3h 18min ago
TriggeredBy: ● docker.socket
       Docs: https://docs.docker.com
   Main PID: 32812 (dockerd)
      Tasks: 20
     Memory: 26.4M
        CPU: 2.491s
     CGroup: /system.slice/docker.service
             └─32812 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/con>

Mar 31 23:23:50 bellatrix dockerd[32812]: time="2023-03-31T23:23:50.539633917Z">
Mar 31 23:23:50 bellatrix dockerd[32812]: time="2023-03-31T23:23:50.539742727Z">
Mar 31 23:23:51 bellatrix dockerd[32812]: time="2023-03-31T23:23:51.529743011Z">
Mar 31 23:23:52 bellatrix dockerd[32812]: time="2023-03-31T23:23:52.129959077Z">
Mar 31 23:23:52 bellatrix dockerd[32812]: time="2023-03-31T23:23:52.365460269Z">
Mar 31 23:23:53 bellatrix dockerd[32812]: time="2023-03-31T23:23:53.019203250Z">
Mar 31 23:23:53 bellatrix dockerd[32812]: time="2023-03-31T23:23:53.019319023Z">
Mar 31 23:23:53 bellatrix dockerd[32812]: time="2023-03-31T23:23:53.174963248Z">
Mar 31 23:23:53 bellatrix systemd[1]: Started Docker Application Container Engi>
Mar 31 23:23:53 bellatrix dockerd[32812]: time="2023-03-31T23:23:53.183494828Z">
</pre>


## :b: Bridges

Docker uses `iptables` and a kernel module called `br_netfilter` to manage inter-container networking. When the Docker daemon starts, it creates a variety of IPTables rules it required to operate.

- [ ] br_netfilter

```
sudo lsmod | grep br_netfilter
```
> Return
```
br_netfilter           28672  0
bridge                176128  1 br_netfilter
```

- [ ] [Forwarding IPv4 and letting iptables see bridged traffic](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#forwarding-ipv4-and-letting-iptables-see-bridged-traffic)

- [ ] iptables

```
sudo iptables --list | grep DOCKER
```
> Return
```
DOCKER-USER  all  --  anywhere             anywhere            
DOCKER-ISOLATION-STAGE-1  all  --  anywhere             anywhere            
DOCKER     all  --  anywhere             anywhere            
Chain DOCKER (1 references)
Chain DOCKER-ISOLATION-STAGE-1 (1 references)
DOCKER-ISOLATION-STAGE-2  all  --  anywhere             anywhere            
Chain DOCKER-ISOLATION-STAGE-2 (1 references)
Chain DOCKER-USER (1 references)
```

- [ ] Check that the service is enabled

```
systemctl list-unit-files | grep docker
```
> Return
```
docker.service                         enabled         enabled      
docker.socket                          enabled         enabled  
```


[:back:](../#round_pushpin-installation-des-services)

# References

- [ ] [Container Runtimes](https://kubernetes.io/docs/setup/production-environment/container-runtimes/)
- [ ] [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
