# :b: Goku :kimono:     
![ebc79dce98f936102358c546946d203a](https://user-images.githubusercontent.com/94937145/228716172-59192808-aa7c-4250-98c6-f2c7c0a91dd3.jpg)
 
| Server           | Hostname                             |  IP               | Specs                 |
|------------------|--------------------------------------|-------------------|-----------------------|
| control plane    |superzaf@son.goku.cherkaoui.tech        | `10.13.237.45/24` | 64GB Ram,      16cpus |
| data plane       |:x:ubuntu@krilin.goku.cherkaoui.tech     | `10.13.237.32/24` | 64GB Ram,      16cpus |
| data plane       |hugopo1@vegeta.goku.cherkaoui.tech     | `10.13.237.30/24` | 64GB Ram,       8cpus |
| data plane       |pasmibalayi@lotus.goku.cherkaoui.tech      | `10.13.237.17/24` | 64GB Ram,      16cpus 
|



```
superzaf@son:~$ sudo kubeadm init   --pod-network-cidr=172.16.0.0/16   
--control-plane-endpoint=son.goku.cherkaoui.tech
```
> Retourne :
<pre>
[init] Using Kubernetes version: v1.26.3
[preflight] Running pre-flight checks
error execution phase preflight: [preflight] Some fatal errors occurred:
	[ERROR CRI]: container runtime is not running: output: time="2023-04-04T21:34:30Z" level=fatal 
msg="validate service connection: CRI v1 runtime API is not implemented for endpoint 
\"unix:///var/run/containerd/containerd.sock\": rpc error: code = Unimplemented desc = unknown service 
runtime.v1.RuntimeService"
, error: exit status 1
[preflight] If you know what you are doing, you can make a check non-fatal with 
`--ignore-preflight-errors=...`
To see the stack trace of this error execute with --v=5 or higher
</pre>

❎ TROUBLESHOOT ⏫

1️⃣  Instruction for containerd fix 

```
sudo rm /etc/containerd/config.toml
sudo systemctl restart containerd
```

2️⃣ Run Kubeadm init

```
sudo kubeadm init
```
<img 
src='https://github.com/CollegeBoreal/INF1100-201-23H-02/blob/main/5.Metal/B.Goku/images/config.toml-fix.png'>

3️⃣ Kubeadm reset 

```
sudo kubeadm reset 
```
<img 
src='https://github.com/CollegeBoreal/INF1100-201-23H-02/blob/main/5.Metal/B.Goku/images/Kubeadm-reset.png'>

✔️ VOILA ! :tada: Félicitations !

<img src='https://github.com/CollegeBoreal/INF1100-201-23H-02/blob/main/5.Metal/B.Goku/images/VOILA!.png'>



 
 # Cluster-info
 ```
 k cluster-info
 ```
 > Retourne :
 <pre>
 <img 
src='https://github.com/CollegeBoreal/INF1100-201-23H-02/blob/main/5.Metal/B.Goku/images/k_cluster_info.png'>
 </pre>


:goat:

<img 
src='https://github.com/CollegeBoreal/INF1100-201-23H-02/blob/main/5.Metal/B.Goku/images/quitefar.png'>

:goat: :star: :sparkles:

<img 
src='https://github.com/CollegeBoreal/INF1100-201-23H-02/blob/main/5.Metal/B.Goku/images/Joinveglot.png'>

:bullettrain_side: eIP
<img src='https://github.com/CollegeBoreal/INF1100-201-23H-02/blob/main/5.Metal/B.Goku/images/eIP.png'>
