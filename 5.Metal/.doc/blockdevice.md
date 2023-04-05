# :roll_of_paper: Le périphérique en mode bloc (Block Device)

Les périphériques en mode bloc réferent souvant aux disques durs dont la lecture se fait en bloc, généralement de 512 octets (bytes)

## :ab: Information sur le périphérique 

`Udev` est le gestionnaire de périphérique du noyau `Linux`. Dynamiquement, Udev crée ou enlève des noeuds de fichiers périphériques au démarrage en fonction du répertoire `/dev` pour tous types de périphériques. `Udev` fait maintenant partie de `systemd` et peut être controllé par `$ systemctl status systemd-udevd`.

- [ ] Pour avoir des informations sur un périphérique: (i.e `/dev/ubuntu-vg/iscsi-lv`)

```
udevadm info --query property --name /dev/ubuntu-vg/iscsi-lv
```
> Retourne
```
 udevadm info --query property --name /dev/ubuntu-vg/iscsi-lv
DEVPATH=/devices/virtual/block/dm-1
DEVNAME=/dev/dm-1
DEVTYPE=disk
MAJOR=253
MINOR=1
SUBSYSTEM=block
USEC_INITIALIZED=18955999
DM_UDEV_DISABLE_LIBRARY_FALLBACK_FLAG=1
DM_UDEV_PRIMARY_SOURCE_FLAG=1
DM_UDEV_RULES=1
DM_UDEV_RULES_VSN=2
DM_NAME=ubuntu--vg-iscsi--lv
DM_UUID=LVM-rezWQCWaDuFq4QzhcU4F3POBUQUJvJDMCYBBEPap5KcvpALZzh1BF1oXQ1QddcG1
DM_SUSPENDED=0
DM_VG_NAME=ubuntu-vg
DM_LV_NAME=iscsi-lv
ID_FS_VERSION=5000
ID_FS_LABEL=cstor-81a8133b-0850-496f-a088-351bc9093fc9
ID_FS_LABEL_ENC=cstor-81a8133b-0850-496f-a088-351bc9093fc9
ID_FS_UUID=29004690544607292
ID_FS_UUID_ENC=29004690544607292
ID_FS_UUID_SUB=17346365271265347888
ID_FS_UUID_SUB_ENC=17346365271265347888
ID_FS_TYPE=zfs_member
ID_FS_USAGE=filesystem
DM_TABLE_STATE=LIVE
DM_STATE=ACTIVE
DEVLINKS=/dev/disk/by-uuid/29004690544607292 /dev/ubuntu-vg/iscsi-lv /dev/disk/by-label/cstor-81a8133b-0850-496f-a088-351bc9093fc9 /dev/mapper/ubuntu--vg-iscsi--lv /dev/disk/by-id/dm-name-ubuntu--vg-iscsi--lv /dev/disk/by-id/dm-uuid-LVM-rezWQCWaDuFq4QzhcU4F3POBUQUJvJDMCYBBEPap5KcvpALZzh1BF1oXQ1QddcG1
TAGS=:systemd:
```

- [ ] pour avoir la taille d'un périphérique

```
sudo fdisk --list /dev/mapper/ubuntu--vg-iscsi--lv
```
> Retourne
```
Disk /dev/mapper/ubuntu--vg-iscsi--lv: 100 GiB, 107374182400 bytes, 209715200 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
```

- [ ] pour avoir son :id: ou encore son **PARTUUID**

```
echo "blockdevice-"`sudo blkid --match-tag PARTUUID --output value /dev/sda3`
```
> Retourne
```
blockdevice-943643da-1a54-4b2f-b1fa-e1c27ba61b96
```

- [ ] pour enfin avoir le nom du noeud

```
uname --nodename
```
> Retourne
```
saiph
```

:building_construction: Ces informations sont requises pour créer le fichier de configuration `yaml` utilisé pour créer le périphérique en mode bloc `block device`. 3 périphériques `(block devices)` sont requis pour former un réservoir `(pool)` de stockage géré par un réseau `iSCSI`

| TAG | Valeur |
|--------------------------------------------|------------------------------------|
| `{metadata.name}`                          | blockdevice-**PARTUUID**           |
| `{metadata.labels.kubernetes.io/hostname}` | **uname --nodename**               |
| `{spec.capacity.storage}`                  | **fdisk --list (taille en octets -- bytes)** |
| `{spec.devlinks.kind[by-id].links}`        | **udevadm info** - DEVLINKS /dev/disk/**by-id(1)**  |
|                                            | **udevadm info**- DEVLINKS /dev/disk/**by-id(2)**  |
| `{spec.devlinks.kind[by-path].links}`      | **udevadm info**- DEVLINKS /dev/**mapper(1)**      |
| `{spec.nodeAttributes.nodeName]`           | **uname --nodename**               |
| `{spec.path}`                              | **udevadm info**- DEVNAME |

:star: Le fichier se présente comme ceci:

```yaml
apiVersion: openebs.io/v1alpha1
kind: BlockDevice
metadata:
  name: blockdevice-18918f5d-e3d0-4e77-9126-febbfbf0366c
  labels:
    kubernetes.io/hostname: saiph
    ndm.io/managed: "false"
    ndm.io/blockdevice-type: blockdevice
status:
  claimState: Unclaimed
  state: Active
spec:
  capacity:
    logicalSectorSize: 512
    storage: 107374182400
  details:
    deviceType: lvm
  devlinks:
  - kind: by-id
    links:
    - /dev/disk/by-id/dm-uuid-LVM-rezWQCWaDuFq4QzhcU4F3POBUQUJvJDMCYBBEPap5KcvpALZzh1BF1oXQ1QddcG1
    - /dev/disk/by-id/dm-name-ubuntu--vg-iscsi--lv
  - kind: by-path
    links:
    - /dev/mapper/ubuntu--vg-iscsi--lv
  nodeAttributes:
    nodeName: saiph
  path: /dev/dm-1
---
```

# :b: Créer le fichier `blockdevice`:

:round_pushpin: Créer un fichier par noeud et le mettre dans le répertoire de la grappe en suivant le modèle ci-dessous:

- [ ] Le nom du fichier devra être sous la forme `blockdevice-xxxx-xxxx-xxx-xxx.yaml`

- [ ] Executer le fichier (remplacer par le bon nom de fichier `blockdevice-xxxx-xxxx-xxx-xxx.yaml`)

```
kubectl apply --namespace openebs --filename blockdevice-xxxx-xxxx-xxx-xxx.yaml
```

:warning: Bien vérifier que le fichier aient les bonnes informations du périphérique `iscsi-lv`

[:back:](../#roll_of_paper-le-périphérique-block-device)


# References

- [ ] [BlockDevice CR creation for partitioned disks](https://mdap.zendesk.com/hc/en-us/articles/360033465571-BlockDevice-CR-creation-for-partitioned-disks)

https://openebs.io/blog/creating-manual-blockdevice/

 - [ ] [Create blockdevice CRs for unsupported disks](https://openebs.io/docs/user-guides/ndm#create-blockdevice-crs-for-unsupported-disks)

 
```yaml
 apiVersion: openebs.io/v1alpha1
 kind: BlockDevice
 metadata:
   name: example-blockdevice-1
   labels:
     kubernetes.io/hostname: <host name in which disk/blockdevice is attached> # like gke-openebs-user-default-pool-044afcb8-bmc0
     ndm.io/managed: "false" # for manual blockdevice creation put false
     ndm.io/blockdevice-type: blockdevice
 status:
   claimState: Unclaimed
   state: Active
 spec:
   capacity:
     logicalSectorSize: 512
     storage: <total capacity in bytes> #like 53687091200
   details:
     deviceType: <device type> # like disk, partition, lvm, crypt, md
     firmwareRevision: <firmware revision>
     model: <model name of blockdevice> # like PersistentDisk
     serial: <serial no of disk> # like google-disk-2
     compliance: <compliance of disk> #like "SPC-4"
     vendor: <vendor of disk> #like Google
   devlinks:
   - kind: by-id
     links:
     - <link1> # like /dev/disk/by-id/scsi-0Google_PersistentDisk_disk-2
     - <link2> # like /dev/disk/by-id/google-disk-2
   - kind: by-path
     links:
     - <link1> # like /dev/disk/by-path/virtio-pci-0000:00:03.0-scsi-0:0:2:0
   nodeAttributes:
     nodeName: <node name> # output of `kubectl get nodes` can be used
   path: <devpath> # like /dev/md0
```

 # References

- [ ] [Beginners Guide to Udev in Linux](https://www.thegeekdiary.com/beginners-guide-to-udev-in-linux)
- [ ] [RAID vs LVM vs ZFS Comparison](https://computingforgeeks.com/raid-vs-lvm-vs-zfs-comparison/)
- [ ] [A hands on demo of Volume Populator using OpenEBS LVM CSI driver](https://openebs.io/blog/a-hands-on-demo-of-volume-populator-using-openebs-lvm-csi-driver)
 - [ ] [OpenEBS - Node Disk Manager](https://openebs.io/docs/concepts/ndm)
    - [ ] [Node Disk Manager User Guide](https://openebs.io/docs/user-guides/ndm)
    - [ ] [Create blockdevice CRs for unsupported disks](https://openebs.io/docs/user-guides/ndm#create-blockdevice-crs-for-unsupported-disks)
    - [ ] [Disk Reservation: How OpenEBS cStor uses this feature from Node Disk Manager](https://medium.com/@sonasingh46/disk-reservation-how-openebs-cstor-uses-this-feature-from-node-disk-manager-d4ff4f96b5d7)
