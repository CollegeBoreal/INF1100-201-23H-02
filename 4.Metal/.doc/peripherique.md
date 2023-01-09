## :infinity: Périphérique en mode Bloc (Block Device)

* finally, let's grab the `DEVLINKS` through `udevadm` using the found `LV Path`

```
$ udevadm info --query property --name /dev/ubuntu-vg/iscsi-lv
DEVPATH=/devices/virtual/block/dm-1
DEVNAME=/dev/dm-1
DEVTYPE=disk
MAJOR=253
MINOR=1
SUBSYSTEM=block
USEC_INITIALIZED=61132596734
DM_UDEV_DISABLE_LIBRARY_FALLBACK_FLAG=1
DM_UDEV_PRIMARY_SOURCE_FLAG=1
DM_UDEV_RULES=1
DM_UDEV_RULES_VSN=2
DM_NAME=ubuntu--vg-iscsi--lv
DM_UUID=LVM-3wU1GsK3RM9v8mInM2B300iKIJ9GlQssrdOs38ndKRjGqB4A4PKc893FS8heIdc3
DM_SUSPENDED=0
DM_VG_NAME=ubuntu-vg
DM_LV_NAME=iscsi-lv
DM_TABLE_STATE=LIVE
DM_STATE=ACTIVE
DEVLINKS=/dev/mapper/ubuntu--vg-iscsi--lv /dev/disk/by-id/dm-uuid-LVM-3wU1GsK3RM9v8mInM2B300iKIJ9GlQssrdOs38ndKRjGqB4A4PKc893FS8heIdc3 /dev/disk/by-id/dm-name-ubuntu--vg-iscsi--lv /dev/ubuntu-vg/iscsi-lv
TAGS=:systemd:
```

:round_pushpin: Let's prepare the Block Device Custom Resource `CR` for all the nodes

The block device name needs to be segregated by node, by convention the string `blockdevice`-`UUID` should be used.
Since dealing with a LV which will be formatted by `openebs`, let's use the Partition UUID of the disk `/dev/sda3` instead. `PARTUUID` can be taken from the below command.

```
$ echo "blockdevice-"`sudo blkid --match-tag PARTUUID --output value /dev/sda3`
blockdevice-23e1292d-32f5-4528-8f7f-3abaee070a03
```

:building_construction: The below file contains 3 node configurations separated by `---` 

| Étiquette :label:                         | Valeur :building_construction: |
|-------------------------------------------|--------------------------------|
| `metadata.name:`                          | blockdevice-**PARTUUID**       |
| `metadata.labels.kubernetes.io/hostname:` | hostname |
| `spec.devlinks.kind: by-id.links:`        | - DEVLINKS /dev/disk/**by-id** |
| `spec.devlinks.kind: by-path.links:`      | - DEVLINKS /dev/**mapper** |
| `spec.nodeAttributes.nodeName:`           | hostname |
| `spec.path:`                              | - DEVNAME |

```yaml
$ kubectl apply -n openebs -f - <<EOF 
 apiVersion: openebs.io/v1alpha1
 kind: BlockDevice
 metadata:
   name: blockdevice-23e1292d-32f5-4528-8f7f-3abaee070a03
   labels:
     kubernetes.io/hostname: bellatrix
     ndm.io/managed: "false"
     ndm.io/blockdevice-type: blockdevice
 status:
   claimState: Unclaimed
   state: Active
 spec:
   capacity:
     logicalSectorSize: 1024
     storage: 102687672
   details:
     deviceType: lvm
   devlinks:
   - kind: by-id
     links:
     - /dev/disk/by-id/dm-uuid-LVM-3wU1GsK3RM9v8mInM2B300iKIJ9GlQssrdOs38ndKRjGqB4A4PKc893FS8heIdc3
     - /dev/disk/by-id/dm-name-ubuntu--vg-iscsi--lv
   - kind: by-path
     links:
     - /dev/mapper/ubuntu--vg-iscsi--lv
   nodeAttributes:
     nodeName: bellatrix
   path: /dev/dm-1
---
