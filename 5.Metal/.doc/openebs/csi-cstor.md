

```
helm repo add openebs-cstor https://openebs.github.io/cstor-operators
```

```
 helm repo update
```

```
 helm repo add ndm https://openebs.github.io/node-disk-manager
```

```
 helm repo update
```


```
 helm install openebs-cstor openebs-cstor/cstor \
           --namespace openebs --create-namespace \
           --set-string csiNode.nodeSelector."openebs\.io/data-plane"=true \
           --set-string openebs-ndm.ndm.nodeSelector."openebs\.io/data-plane"=true \
           --set openebs-ndm.featureGates.UseOSDisk.enabled=true
```


- [ ] Print Logs

```
 kubectl logs openebs-cstor-csi-controller-0 --namespace openebs --container csi-provisioner
```
