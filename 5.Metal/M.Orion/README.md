# :m: Grappe Orion

| Type Server   | Hostname                     |  IP               | Specs                 | Availability |
|---------------|------------------------------|-------------------|-----------------------|--------------|
| control plane | betelgeuse.orion.gasy.africa | `10.13.15.200/20` | 64GB Ram,      16cpus | :heavy_check_mark: |
| data plane    | bellatrix.orion.gasy.africa  | `10.13.15.201/20` | 64GB Ram,      16cpus | :heavy_check_mark: |
| data plane    | rigel.orion.gasy.africa      | `10.13.15.202/20` | 32GB Ram,      16cpus |
| data plane    | saiph.orion.gasy.africa      | `10.13.15.203/20` | 64GB Ram,      16cpus |



:one: kubectl apply [csi-cstor-sc](csi-cstor-sc.md)

[:x:](https://github.com/openebs/openebs/issues/3046) failed calling webhook "admission-webhook.openebs.io" Error
```
Error from server (InternalError): error when creating "STDIN": Internal error occurred: failed calling webhook "admission-webhook.cstor.openebs.io": Post https://openebs-cstor-admission-server.openebs.svc:443/validate?timeout=5s: dial tcp 10.102.15.93:443: connect: no route to host
```

:two: change the validatingwebhookConfiguration `failurePolicy` to `Ignore` by Editing 

from `failurePolicy: Fail` to   `failurePolicy: Ignore`

```
 kubectl edit validatingwebhookconfiguration openebs-cstor-validation-webhook
```
> Return
```
validatingwebhookconfiguration.admissionregistration.k8s.io/openebs-cstor-validation-webhook edited
```

https://github.com/openebs/cstor-operators/blob/develop/docs/quick.md
