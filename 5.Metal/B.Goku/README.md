# :b: Goku :kimono:     ![ebc79dce98f936102358c546946d203a](https://user-images.githubusercontent.com/94937145/228716172-59192808-aa7c-4250-98c6-f2c7c0a91dd3.jpg)
 
| Server           | Hostname                             |  IP               | Specs                 |
|------------------|--------------------------------------|-------------------|-----------------------|
| control plane    |superzaf@son.goku.cherkaoui.tech        | `10.13.237.45/24` | 64GB Ram,      16cpus |
| data plane       |ubuntu@krilin.goku.cherkaoui.tech     | `10.13.237.32/24` | 64GB Ram,      16cpus |
| data plane       |hugopo1@vegeta.goku.cherkaoui.tech     | `10.13.237.30/24` | 64GB Ram,       8cpus |
| data plane       |pasmibalayi@lotus.goku.cherkaoui.tech      | `10.13.237.17/24` | 64GB Ram,      16cpus |



superzaf@son:~$ sudo kubeadm init   --pod-network-cidr=172.16.0.0/16   --control-plane-endpoint=son.goku.cherkaoui.tech
[init] Using Kubernetes version: v1.26.3
[preflight] Running pre-flight checks
error execution phase preflight: [preflight] Some fatal errors occurred:
	[ERROR CRI]: container runtime is not running: output: time="2023-04-04T21:34:30Z" level=fatal msg="validate service connection: CRI v1 runtime API is not implemented for endpoint \"unix:///var/run/containerd/containerd.sock\": rpc error: code = Unimplemented desc = unknown service runtime.v1.RuntimeService"
, error: exit status 1
[preflight] If you know what you are doing, you can make a check non-fatal with `--ignore-preflight-errors=...`
To see the stack trace of this error execute with --v=5 or higher

```
```

```
```

