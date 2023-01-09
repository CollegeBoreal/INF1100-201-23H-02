## :zero: Preparation du serveur

- [ ] Make sure you have the right hostname (based on your cluster)

```
$ hostnamectl --static set-hostname betelgeuse
```


## :one: Disabling the swap (otherwise Kubernetes won't work) 

[how-do-i-disable-swap?](https://askubuntu.com/questions/214805/how-do-i-disable-swap)

- [ ] Before

```
$ free --human
              total        used        free      shared  buff/cache   available
Mem:           62Gi       440Mi        61Gi       1.0Mi       1.4Gi        61Gi
Swap:           8Gi           0         8Gi
```

- [ ] swap off and disabled at boot in `/etc/fstab` file

```
sudo swapoff --all && sudo sed --regexp-extended --in-place '/\sswap\s/s/^#?/#/' /etc/fstab
```

- [ ] After

```
$ free --human
              total        used        free      shared  buff/cache   available
Mem:           62Gi       440Mi        61Gi       1.0Mi       1.4Gi        61Gi
Swap:            0B          0B          0B
```

- [ ] Check `swap` in `/etc/fstab` is commented

```
$ cat /etc/fstab 
# /etc/fstab: static file system information.
...
#/swap.img	none	swap	sw	0	0
```

## :two: [Letting iptables see bridged traffic](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#letting-iptables-see-bridged-traffic)

[sysctl](https://wiki.archlinux.org/index.php/sysctl) is a tool for examining and changing kernel parameters at runtime . sysctl is implemented in `procfs`, the virtual process file system at `/proc/`.

for more details, see [sysctl-cluster](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster) in Kubernetes

:round_pushpin: Enable the usage of iptables. To prevent some routing errors happening, add runtime parameters:

- [ ] Enable the parameters by setting them to 1 for both IPv6 and IPv4

##### :gear: k8s.conf [drop-in file](https://stackoverflow.com/questions/59842743/what-is-a-drop-in-file-what-is-a-drop-in-directory-how-to-edit-systemd-service) (i.e. sysctl .conf file)

```
sudo bash -c 'echo "net.bridge.bridge-nf-call-ip6tables = 1" > /etc/sysctl.d/k8s.conf' && \
sudo bash -c 'echo "net.bridge.bridge-nf-call-iptables  = 1" >> /etc/sysctl.d/k8s.conf'
```

- [ ] reload the configuration

```
sudo sysctl --system
```

[:back:](../#round_pushpin-le-serveur)
