# OpenEBS - Operations d'administration

:control_knobs: Sur le plan de contrôle

https://openebs.io/docs/#admin-operations

## :a: Les Périphériques en mode bloc - BlockDevice CR (Custom Resource)


- [ ] Créer les périphériques :roll_of_paper:

> Éxécuter les commandes `kubectl` se reférant aux fichiers `blockdevice-****-****-****-****.md`

:bulb: Il devrait y avoir :three: fichiers à éxécuter


- [ ] Vérifier la création des périphériques

> blockdevices or bd

```
kubectl get blockdevices --namespace openebs   
```
> Retourne
<pre>
NAME                                               NODENAME    SIZE           CLAIMSTATE   STATUS   AGE
blockdevice-23e1292d-32f5-4528-8f7f-3abaee070a03   bellatrix   107374182400   Unclaimed    Active   4m2s
blockdevice-3fa7d473-d0f1-4532-bcd4-a402241eeff1   saiph       107374182400   Unclaimed    Active   3m41s
blockdevice-7e848c90-cca2-4ef4-9fdc-90cff05d5bb5   rigel       107374182400   Unclaimed    Active   3m26s
</pre>

> blockdeviceclaims or bdc

```
kubectl get blockdeviceclaims.openebs.io --namespace openebs
```
> Retourne
<pre>
NAME                                       BLOCKDEVICENAME                                    PHASE   AGE
bdc-0fcbd750-d9bc-484c-bc4b-d3b800bf5425   blockdevice-3fa7d473-d0f1-4532-bcd4-a402241eeff1   Bound   17h
bdc-562edaf1-6aef-485b-b83f-a7ddd73efcd3   blockdevice-23e1292d-32f5-4528-8f7f-3abaee070a03   Bound   17h
bdc-a68503ba-9882-459d-9e36-da24c54e1977   blockdevice-7e848c90-cca2-4ef4-9fdc-90cff05d5bb5   Bound   17h
</pre>

## :b: Le réservoir de stockage - Storage Pool

:round_pushpin: Créer le réservoir de stockage `cstor` `cStor Storage Pool` (csp)

- [ ] modifier le fichier de configuration ci-dessous en changeant les périphériques `block device`

```yaml
apiVersion: cstor.openebs.io/v1
kind: CStorPoolCluster
metadata:
 name: cstor-storage
 namespace: openebs
spec:
 pools:
   - nodeSelector:
       kubernetes.io/hostname: "bellatrix" # ME CHANGER VITE
     dataRaidGroups:
       - blockDevices:
           - blockDeviceName: "blockdevice-23e1292d-32f5-4528-8f7f-3abaee070a03" # ME CHANGER VITE
     poolConfig:
       dataRaidGroupType: "stripe"

   - nodeSelector:
       kubernetes.io/hostname: "saiph" # ME CHANGER VITE
     dataRaidGroups:
       - blockDevices:
           - blockDeviceName: "blockdevice-3fa7d473-d0f1-4532-bcd4-a402241eeff1" # ME CHANGER VITE
     poolConfig:
       dataRaidGroupType: "stripe"

   - nodeSelector:
       kubernetes.io/hostname: "rigel" # ME CHANGER VITE
     dataRaidGroups:
       - blockDevices:
           - blockDeviceName: "blockdevice-7e848c90-cca2-4ef4-9fdc-90cff05d5bb5" # ME CHANGER VITE
     poolConfig:
       dataRaidGroupType: "stripe"
---
```

:round_pushpin: Sauveguarder le fichier `cspc-single.yaml`

- [ ] après avoir modifier les périphériques sauvegarder sous le nom `cspc-single.yaml` dans le répertoire de votre grappe

- [ ] Exécuter la commande `kubectl` à partir du fichier.

```
kubectl apply --filename cspc-single.yaml
```

:round_pushpin: Vérifier que les périphériques passent à l'état `claimed` - Contesté

```
$ kubectl get blockdevices --namespace openebs
NAME                                               NODENAME    SIZE        CLAIMSTATE   STATUS   AGE
blockdevice-23e1292d-32f5-4528-8f7f-3abaee070a03   bellatrix   102687672   Claimed      Active   16m
blockdevice-3fa7d473-d0f1-4532-bcd4-a402241eeff1   saiph       102687672   Claimed      Active   16m
blockdevice-7e848c90-cca2-4ef4-9fdc-90cff05d5bb5   rigel       102687672   Claimed      Active   16m
```

## :ab: [Classe de Stockage](https://kubernetes.io/docs/concepts/storage/storage-classes/)

:round_pushpin: Créer la **Class de Stockage** `standard` 

- [ ] après avoir modifié la valeur du champ `ReplicaCount` au nombre de noeuds sur la grappe (idéalement :three:)

```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: standard
provisioner: cstor.csi.openebs.io
allowVolumeExpansion: true
parameters:
  cas-type: cstor
  # cstorPoolCluster should have the name of the CSPC
  cstorPoolCluster: cstor-storage
  # replicaCount should be <= no. of CSPI
  replicaCount: "3"
---
```

- [ ] sauvegarder sous le nom `csi-cstor-sc.yaml` dans le répertoire de votre grappe
- [ ] Exécuter la commande `kubectl` à partir du fichier.

```
kubectl apply --filename csi-cstor-sc.yaml
```

:round_pushpin: La classe par défaut de stockage `standard`

- [ ] Vérifier la classe de stockage `standard`

```
kubectl get storageclass standard
```
> Retourne :
<pre>
NAME                        PROVISIONER                                                RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
standard                    cstor.csi.openebs.io                                       Delete          Immediate              true                   4s
</pre>

- [ ] Appliquer le stockage par défaut à **standard**

```
kubectl patch storageclass standard -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```

[:back:](../../#floppy_disk-le-stockage)

# References

- [ ] [OpenEBS: cStor storage engine on KVM](https://technology.amis.nl/platform/openebs-cstor-storage-engine-on-kvm)
- [ ] [Mayastor is fastest open source storage, Intel says. So where are the numbers?](https://blocksandfiles.com/2021/03/08/intel-says-mayastor-is-fastest-open-source-storage)
- [ ] [What do you see when you put container storage firms into the sorting triangle?](https://blocksandfiles.com/2021/03/05/data-storage-news-digest-container-storage/)

- [ ] [cStor Operators - Quick Guide](https://github.com/openebs/cstor-operators/blob/develop/docs/quick.md)
    - [ ] [SPC based cStor Guide - deprecated](https://openebs.io/docs/deprecated/spc-based-cstor)

- [ ] [CSTOR Storage Engine Components](https://github.com/openebs/openebsctl/tree/develop/docs/cstor)
- [ ] [OpenEBSCTL is a kubectl plugin to manage OpenEBS storage components.](https://github.com/openebs/openebsctl)
```
   $ kubectl krew list
   PLUGIN   VERSION
   krew     v0.4.3
   openebs  v0.5.0
```

:bulb: A required privilege is not held by the client.

```
PS> kubectl krew install openebs
Updated the local copy of plugin index.
Installing plugin: openebs
Installed plugin: openebs
\
 | Use this plugin:
 |      kubectl openebs
 | Documentation:
 |      https://github.com/openebs/openebsctl
 | Caveats:
 | \
 |  | * This plugin works with newer OpenEBS releases, where volumes are
 |  |   provisioned by CSI.
 |  | * For resources that are not in default namespace, you must specify
 |  |   -n/--namespace explicitly (the current namespace setting is not
 |  |   yet used).
 | /
/
[31;1mWARNING: [0mYou installed plugin "openebs" from the krew-index plugin repository.
   These plugins are not audited for security by the Krew maintainers.
   Run them at your own risk.
```

```
filterconfigs:
  - key: os-disk-exclude-filter
    name: os disk exclude filter
    state: true
    exclude: "/,/etc/hosts,/boot"
  - key: vendor-filter
    name: vendor filter
    state: true
    include: ""
    exclude: "CLOUDBYT,OpenEBS"
  - key: path-filter
    name: path filter
    state: true
    include: ""
    exclude: "loop,fd0,sr0,/dev/ram,/dev/dm-,/dev/md,/dev/rbd,/dev/zd"
```

