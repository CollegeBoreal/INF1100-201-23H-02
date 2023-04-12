

# :a: Six (the :six:)

https://www.urbandictionary.com/define.php?term=The%20Six

| Server           | Hostname                             |  IP               | Specs                 |
|------------------|--------------------------------------|-------------------|-----------------------|
| control plane    |bakmomo@toronto.six.mbtechno.tech      | `10.13.237.31/24` | 64GB Ram,      16cpus |
| data plane       |rafik952@mississauga.six.mbtechno.tech  | `10.13.237.40/24` | 64GB Ram,      16cpus |
| data plane       |salimata1@brampton.six.mbtechno.tech     | `10.13.237.10/24` | 64GB Ram,       8cpus |
| data plane       |sara@aurora.six.mbtechno.tech       | `10.13.237.35/24` | 64GB Ram,      16cpus |


```
bakmomo@toronto:~$ sudo apt update
```
>Resultat

```
Hit:1 https://download.docker.com/linux/ubuntu jammy InRelease
Hit:3 http://archive.ubuntu.com/ubuntu jammy InRelease
Hit:4 http://archive.ubuntu.com/ubuntu jammy-updates InRelease
Hit:5 http://archive.ubuntu.com/ubuntu jammy-backports InRelease
Get:2 https://packages.cloud.google.com/apt kubernetes-xenial InRelease [8,993 B]
Hit:6 http://archive.ubuntu.com/ubuntu jammy-security InRelease
Err:2 https://packages.cloud.google.com/apt kubernetes-xenial InRelease
  The following signatures couldn't be verified because the public key is not available: NO_PUBKEY B53DC80D13EDEF05
Fetched 8,993 B in 1s (12.9 kB/s)
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
All packages are up to date.
W: An error occurred during the signature verification. The repository is not updated and the previous index files will be used. GPG error: https://packages.cloud.google.com/apt kubernetes-xenial InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY B53DC80D13EDEF05
W: Failed to fetch https://apt.kubernetes.io/dists/kubernetes-xenial/InRelease  The following signatures couldn't be verified because the public key is not available: NO_PUBKEY B53DC80D13EDEF05
W: Some index files failed to download. They have been ignored, or old ones used instead.

```




