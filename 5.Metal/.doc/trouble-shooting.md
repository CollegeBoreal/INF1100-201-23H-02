

:one: stat /var/lib/calico/nodename: no such file or directory problem,please help.

https://github.com/projectcalico/calico/issues/1795

``` 
$ echo "ajax" > /var/lib/calico/nodename ; echo "1480" > /var/lib/calico/mtu
```

:two: failed calling webhook "admission-webhook.openebs.io": Post https://admission-server-svc.openebs.svc:443/validate?timeout=5s: context deadline exceeded #3046

https://github.com/openebs/openebs/issues/3046

```
$ export KUBEHOME=~/Developer/INF1087-200-21H-02/5.Metal/M.GTA; export KUBECONFIG=$KUBEHOME/.kube/config
```

```
$ kubectl edit validatingwebhookconfigurations  openebs-validation-webhook-cfg
```

Edit : failurePolicy: Ignore 
