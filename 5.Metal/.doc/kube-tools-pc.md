# :toolbox: Outils Kubernetes

## :bookmark_tabs: Cheat Sheet

[ :blue_book: ](./Kubernetes-Cheat-Sheet_07182019.pdf) https://linuxacademy.com/blog/containers/kubernetes-cheat-sheet/

Kubernetes (communément appelé « K8s2 ») est un système open source qui vise à fournir une « plate-forme permettant d'automatiser le déploiement, la montée en charge et la mise en œuvre de conteneurs d'application sur des grappes de serveurs. Il fonctionne avec toute une série de technologies de conteneurisation, et est souvent utilisé avec Docker. Il a été conçu à l'origine par Google, puis offert à la [CNCF](https://www.cncf.io/) (Cloud Native Computing Foundation) .


## :a: `kubectl` Client

:gear: Installer l'utilitaire client `kubectl` permetant de controller la grappe

:computer: Sous Windows avec choco

```
choco install kubernetes-cli
```

:apple: Sous MacOS avec HomeBrew

```
brew install kubernetes-cli
```


https://kubernetes.io/docs/tasks/tools/install-kubectl/


- [x] La version

```
kubectl version --client --output=json
```
> Retourne :
```json
{
  "clientVersion": {
    "major": "1",
    "minor": "26",
    "gitVersion": "v1.26.3",
    "gitCommit": "9e644106593f3f4aa98f8a84b23db5fa378900bd",
    "gitTreeState": "clean",
    "buildDate": "2023-03-15T13:33:11Z",
    "goVersion": "go1.19.7",
    "compiler": "gc",
    "platform": "darwin/amd64"
  },
  "kustomizeVersion": "v4.5.7"
}
```

#### Autocompletion (bash or zsh)

https://kubernetes.io/docs/tasks/tools/install-kubectl/#enable-kubectl-autocompletion

```
$ source <(kubectl completion bash) # for zsh replace bash with zsh
```

- [ ] Source the completion script in your `~/.bashrc` or `~/.zshrc`file:

```
$ echo 'source <(kubectl completion bash)' >>~/.bashrc # for zsh replace bash with zsh
```

- [ ] Add the completion script to the `/etc/bash_completion.d` directory: (on Linux)

```
$ kubectl completion bash >/etc/bash_completion.d/kubectl
```

## :b: Helm :package: 

https://helm.sh/docs/intro/install/#from-script

:apple: Mac OS

```
brew install helm
```

:computer: Windows

```
choco install kubernetes-helm
```

## :ab: IDE LENS :level_slider:

https://k8slens.dev/

:apple: Mac OS

```
brew install lens
```

:computer: Windows

```
choco install lens
```

## :o2: Le context

:star: Switching Kubernetes Context

```
kubectl config get-contexts
```
> Retourne :
<pre>
CURRENT   NAME                                 CLUSTER                              AUTHINFO                          NAMESPACE
          docker-desktop                       docker-desktop                       docker-desktop
          docker-for-desktop                   docker-desktop                       docker-desktop
          minikube                             minikube                             minikube
          gke_b300098957_us-central1-a_kubia   gke_b300098957_us-central1-a_kubia   gke_b300098957_us-central1-a_kubia   
*         kubia                                kubia                                clusterUser_college-boreal_kubia    
</pre>

:star: Set the context to use as docker-for-desktop:

```
kubectl config use-context docker-for-desktop
```

https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/

```
$ kubectl cluster-info dump
```

#### :interrobang:  [Merge](https://stackoverflow.com/questions/46184125/how-to-merge-kubectl-config-file-with-kube-config) Config

``` 
$ KUBECONFIG=~/.kube/orion:~/.kube/config kubectl config view --flatten > ~/.kube/config
``` 
