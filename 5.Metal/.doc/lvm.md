# :cd: Volume Logique (lv)

:bulb: Si vous avez déjà fail l'activité [L.LVM](https://github.com/CollegeBoreal/Tutoriels/tree/main/O.OS/1.Linux/L.LVM), [:eye: vérifier](#eye-vérifier-si-le-volume-logique-a-été-créé) :writing_hand: seulement que le volume logique `iscsi-lv` a été créé 

## :100:G 

- [ ] Créer le volume logique à :100:G

```
sudo lvcreate --name iscsi-lv --size 100G  ubuntu-vg
```
> Retourne :
<pre>
Logical volume "iscsi-lv" created.
</pre>

- [ ] Vérifier si il a été créé

```
lsblk /dev/sda --output NAME,SIZE,TYPE,FSSIZE,FSTYPE,FSUSED,FSUSE%,MOUNTPOINT 
```
> Retourne
```
NAME                        SIZE TYPE FSSIZE FSTYPE      FSUSED FSUSE% MOUNTPOINT
sda                       273.4G disk                                  
├─sda1                        1M part                                  
├─sda2                        1G part 975.9M ext4        293.4M    30% /boot
└─sda3                    272.4G part        LVM2_member               
  ├─ubuntu--vg-ubuntu--lv 136.2G lvm  133.1G ext4         12.4G     9% /
  └─ubuntu--vg-iscsi--lv    100G lvm                                   
```

:bangbang: Si il n'y a plus assez d'espace

```
sudo lvcreate --name iscsi-lv --size 100G  ubuntu-vg
```
> Retourne
```
  Volume group "ubuntu-vg" has insufficient free space (9267 extents): 102400 required.
```

- [ ] Créer le volume logique avec l'espace restant

```
sudo lvcreate --name iscsi-lv --extents 100%FREE ubuntu-vg
```
> Retourne
```
  Logical volume "iscsi-lv" created.
```

## :eye: Vérifier si le volume logique a été créé

```
lsblk /dev/sda --output NAME,SIZE,TYPE,FSSIZE,FSTYPE,FSUSED,FSUSE%,MOUNTPOINT 
```
> Retourne
```yaml
NAME                        SIZE TYPE FSSIZE FSTYPE      FSUSED FSUSE% MOUNTPOINT
sda                       273.4G disk                                  
├─sda1                        1M part                                  
├─sda2                      1.5G part   1.4G ext4          223M    15% /boot
└─sda3                    271.9G part        LVM2_member               
  ├─ubuntu--vg-ubuntu--lv   100G lvm   97.9G ext4           15G    15% /
  └─ubuntu--vg-iscsi--lv    100G lvm                              
```


## [:back:](../#roll_of_paper-le-périphérique-block-device)
