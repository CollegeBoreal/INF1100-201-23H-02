# :wheel_of_dharma: Kubernetes

![image](images/full-kubernetes-model-architecture.png)


:gear: Kube Config

<img src=images/Lens_Config.png width='' height='' > </img>

```
k config get-clusters
```
```yaml
NAME
kind-k8s
kubernetes
```

```
k config get-contexts
```
```yaml
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
*         kubernetes-admin@kubernetes   kubernetes   kubernetes-admin   
```



:knot: Noeuds

<img src=images/Lens_Nodes.png width='' height='' > </img>

```
 k get no
```
```yaml
NAME         STATUS   ROLES           AGE   VERSION
bellatrix    Ready    <none>          43h   v1.26.3
betelgeuse   Ready    control-plane   43h   v1.26.3
```
