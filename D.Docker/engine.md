# :tractor: Docker Engine

```
  Ce tutoriel explique comment installer une machine Docker sur une machine physique (métal)

  Le 'Driver' Docker à utilser est le generique `generic`
```

## :bangbang: Sur le serveur :penguin: `Linux` 

### :one: Installer Docker Engine sur la machine physique (i.e. Ubuntu)

** dans le cas échéant, installer `curl` si non présent (suivre les instructions du serveur)

* Installer `Docker` avec le [`convenient script`](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script) dans un environnement de  développement

```
sudo curl -sSL https://get.docker.com | sh
```
> Outputs :
<pre>
[sudo] password for ubuntu: 
# Executing docker install script, commit: 66474034547a96caa0a25be56051ff8b726a1b28
+ sudo -E sh -c apt-get update -qq >/dev/null
+ sudo -E sh -c DEBIAN_FRONTEND=noninteractive apt-get install -y -qq apt-transport-https ca-certificates curl >/dev/null
+ sudo -E sh -c mkdir -p /etc/apt/keyrings && chmod -R 0755 /etc/apt/keyrings
+ sudo -E sh -c curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg
+ sudo -E sh -c chmod a+r /etc/apt/keyrings/docker.gpg
+ sudo -E sh -c echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu focal stable" > /etc/apt/sources.list.d/docker.list
+ sudo -E sh -c apt-get update -qq >/dev/null
+ sudo -E sh -c DEBIAN_FRONTEND=noninteractive apt-get install -y -qq docker-ce docker-ce-cli containerd.io docker-scan-plugin docker-compose-plugin docker-ce-rootless-extras docker-buildx-plugin >/dev/null
+ sudo -E sh -c docker version
Client: Docker Engine - Community
 Version:           23.0.1
 API version:       1.42
 Go version:        go1.19.5
 Git commit:        a5ee5b1
 Built:             Thu Feb  9 19:46:56 2023
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          23.0.1
  API version:      1.42 (minimum version 1.12)
  Go version:       go1.19.5
  Git commit:       bc3805a
  Built:            Thu Feb  9 19:46:56 2023
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.6.18
  GitCommit:        2456e983eb9e37e47538f59ea18f2043c9a73640
 runc:
  Version:          1.1.4
  GitCommit:        v1.1.4-0-g5fd4c4d
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0

================================================================================

To run Docker as a non-privileged user, consider setting up the
Docker daemon in rootless mode for your user:

    dockerd-rootless-setuptool.sh install

Visit https://docs.docker.com/go/rootless/ to learn about rootless mode.


To run the Docker daemon as a fully privileged service, but granting non-root
users access, refer to https://docs.docker.com/go/daemon-access/

WARNING: Access to the remote API on a privileged Docker daemon is equivalent
         to root access on the host. Refer to the 'Docker daemon attack surface'
         documentation for details: https://docs.docker.com/go/attack-surface/

================================================================================
</pre>

* Verifier que le service fonctionne

```
systemctl status docker # doit être actif - Active: active (running) since ...
```
> Outputs :
<pre>
● docker.service - Docker Application Container Engine
     Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
     Active: active (running) since Fri 2023-03-17 14:17:20 UTC; 1min 31s ago
TriggeredBy: ● docker.socket
       Docs: https://docs.docker.com
   Main PID: 114945 (dockerd)
      Tasks: 14
     Memory: 29.8M
     CGroup: /system.slice/docker.service
             └─114945 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock

Mar 17 14:17:19 betelgeuse dockerd[114945]: time="2023-03-17T14:17:19.439773584Z" level=info msg="[core] [Cha>
Mar 17 14:17:19 betelgeuse dockerd[114945]: time="2023-03-17T14:17:19.533008944Z" level=info msg="Loading con>
Mar 17 14:17:20 betelgeuse dockerd[114945]: time="2023-03-17T14:17:20.111369570Z" level=info msg="Default bri>
Mar 17 14:17:20 betelgeuse dockerd[114945]: time="2023-03-17T14:17:20.189804541Z" level=info msg="Loading con>
Mar 17 14:17:20 betelgeuse dockerd[114945]: time="2023-03-17T14:17:20.202002319Z" level=warning msg="WARNING:>
Mar 17 14:17:20 betelgeuse dockerd[114945]: time="2023-03-17T14:17:20.202047580Z" level=info msg="Docker daem>
Mar 17 14:17:20 betelgeuse dockerd[114945]: time="2023-03-17T14:17:20.202150926Z" level=info msg="Daemon has >
Mar 17 14:17:20 betelgeuse dockerd[114945]: time="2023-03-17T14:17:20.220793310Z" level=info msg="[core] [Ser>
Mar 17 14:17:20 betelgeuse systemd[1]: Started Docker Application Container Engine.
Mar 17 14:17:20 betelgeuse dockerd[114945]: time="2023-03-17T14:17:20.228586993Z" level=info msg="API listen 
</pre>

* Permettre l'accès au service au démarrage de la machine

```
sudo systemctl enable docker
```


### :two: Permissions

* Lister les conteneurs donne une erreur de permission quand à l'accès des [socket-files](https://askubuntu.com/questions/372725/what-are-socket-files)

Les [socket-files](https://askubuntu.com/questions/372725/what-are-socket-files) sont utilisé pour communiquer entre applications gràce aux [IPC](https://en.wikipedia.org/wiki/Inter-process_communication)

```
docker container ls
```
> Outputs :
<pre>
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: 
Get http://%2Fvar%2Frun%2Fdocker.sock/v1.40/containers/json: 
dial unix /var/run/docker.sock: connect: permission denied
</pre>

* Permettre l'accès au `socket file` en rajoutant votre utilisateur au groupe `docker`

```
sudo usermod --append --groups docker $USER
```

* Pour verifier, sortir du terminal et lancer la commande `groups`, `docker` doit apparaitre

:warning: pour forcer le group il faut sortir de la session avec `exit` et revenir dans le serveur

```
groups
```
> ubuntu adm cdrom sudo dip plugdev lxd docker


[ :back: ](README.md#ddocker-whale)

# References

- [ ] [Docker Engine](https://github.com/CollegeBoreal/Tutoriels/tree/main/2.MicroServices/1.Containers/2.Docker/1.Engine/2.Linux)
- [ ] [How to solve docker: Got permission denied while trying to connect to the Docker daemon socket?](https://medium.com/nerd-for-tech/how-to-solve-docker-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket-82e81ab012b7)
