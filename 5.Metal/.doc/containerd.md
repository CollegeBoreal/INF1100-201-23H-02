# :whale2: Installer le `CRI`  `containerd.io`

- [ ] Installer le paquet `containerd.io` 
- [ ] Régler le `cgroup` lié à `SystemD` [:bangbang: Issues with "stability" with Kubernetes cluster before adding networking](https://stackoverflow.com/questions/72567945/issues-with-stability-with-kubernetes-cluster-before-adding-networking/73743910#73743910)

* Ajouter Changer le fichier de configuration `/etc/containerd/config.toml`

```
containerd config default | sudo tee /etc/containerd/config.toml
```

* Modifier le `CGroup` à VRAI

```
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
```

* Vérifier le `CGroup` à VRAI

```
sudo cat /etc/containerd/config.toml | grep SystemdCgroup
```
>            SystemdCgroup = true

* Supprimer l'ancien paquet (note: il n'y a pas de `.io`)

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

- [ ] Installer le nouveau paquet `containerd.io`

* mettre à jour

```
sudo apt update
```

* Installer

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

# [:back:](../#round_pushpin-installation-des-services)

# References

- [ ] [Updated: Dockershim Removal FAQ](https://kubernetes.io/blog/2022/02/17/dockershim-faq/)


## [if not add "version = 2" to the /etc/containerd/config.toml, some configuration will be ingored](https://github.com/containerd/containerd/issues/5237)

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
crictl info
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

