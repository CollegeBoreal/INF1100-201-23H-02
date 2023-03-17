# KIND - Kubernetes In Docker


# :warning: Tries to install Docker-Desktop (on Windows Server)

| Docker Engine | Windows | Linux | 
|---------------|---------|-------|
| kind          | :heavy_check_mark: | :heavy_check_mark: |



## :o: Install 

#### :round_pushpin: KIND

:desktop_computer: Windows

```
choco install kind
```

:apple: MacOS

```
brew install kind
```

:penguin: Ubuntu

```
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```

#### :round_pushpin: kubectl (kube control)

:desktop_computer: Windows

```
choco install kubectl
```

:apple: MacOS

```
brew install kubectl
```

:penguin: Ubuntu

* add `--classic` if requested

```
snap install kubectl
```


## :a: Run single node



```
kind create cluster --name k8s
```

<img src="images/kind-k8s.png" width="1580" heigth="708"></img>

- [ ] Get contexts

```
kubectl config get-contexts   
```
> Outputs :
<pre>
CURRENT   NAME       CLUSTER    AUTHINFO   NAMESPACE
*         kind-k8s   kind-k8s   kind-k8s   
</pre>

- [ ] Use contexts

```
$ kubectl config use-context kind-k8s
```

## :b: Run multiple nodes

- [ ] Create a folder with your :id:

:pushpin: in youo :id: folder, edit file `HA-config.yaml`

```yaml
# HA-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: control-plane
- role: control-plane
- role: worker
- role: worker
- role: worker
```

:pushpin: Run the cluster

```
kind create cluster --name k8s-ha --config HA-config.yaml 
```

<img src="images/kind-k8s-ha.png" width="2440" heigth="856"></img>

```
kubectl cluster-info --context kind-k8s-ha
```
> Outputs :
<pre>
Kubernetes control plane is running at https://127.0.0.1:37641
CoreDNS is running at https://127.0.0.1:37641/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
<pre>

```
kubectl config get-contexts                              
```
> Outputs :
<pre>
CURRENT   NAME          CLUSTER       AUTHINFO      NAMESPACE
          kind-k8s      kind-k8s      kind-k8s      
*         kind-k8s-ha   kind-k8s-ha   kind-k8s-ha
</pre>

<img src="images/kind-k8s-ha-container.png" width="2686" heigth="278"></img>

```
kubectl get nodes                     
```
> Outputs :
<pre>
NAME                    STATUS   ROLES           AGE   VERSION
k8s-ha-control-plane    Ready    control-plane   35m   v1.25.3
k8s-ha-control-plane2   Ready    control-plane   34m   v1.25.3
k8s-ha-control-plane3   Ready    control-plane   34m   v1.25.3
k8s-ha-worker           Ready    <none>          33m   v1.25.3
k8s-ha-worker2          Ready    <none>          33m   v1.25.3
k8s-ha-worker3          Ready    <none>          33m   v1.25.3
</pre>

## :x: Remove Cluster

```
kind delete cluster --name k8s
```

```
kubectl config get-contexts                              
```
> Outputs :
<pre>
CURRENT   NAME          CLUSTER       AUTHINFO      NAMESPACE
*         kind-k8s-HA   kind-k8s-HA   kind-k8s-HA   
          minikube      minikube      minikube   
</pre>

## :x: Force removing if issues

```
% rm ~/.kube/config
```

```
% docker rm -f `docker container ls -q`
```

# References

- [ ] [Quick Start](https://kind.sigs.k8s.io/docs/user/quick-start/)
- [ ] [Launching Remote KIND (Kubernetes in Docker) Clusters](https://www.mendrugory.com/post/remote-kind)
