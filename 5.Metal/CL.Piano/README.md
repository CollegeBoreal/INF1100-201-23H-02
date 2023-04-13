# :cl: Piano :musical_keyboard:

 https://fr.wikipedia.org/wiki/Piano

| Server           | Hostname                             |  IP               | Specs                 |
|------------------|--------------------------------------|-------------------|-----------------------|
| control plane    | klyd@do.piano.klyddom.tech | `10.13.237.16/24` | 64GB Ram,      16cpus |
| data plane       | frank_uranus@re.piano.klyddom.tech | `10.13.237.34/24` | 64GB Ram,      16cpus |
| data plane       | ziko@mi.piano.klyddom.tech | `10.13.237.39/24` | 64GB Ram,       8cpus |
| data plane       | sedric_g@fa.piano.klyddom.tech | `10.13.237.36/24` | 64GB Ram,      16cpus |

```
kubeadm join do.piano.klyddom.tech:6443 --token 1eytpq.yj317xna5nl4a594 --discovery-token-ca-cert-hash sha256:83eef2dac5d014d563c236f632c2aecef61533bcd197c759ea28caea1eef5382
```

```
kubeadm join mi.piano.klyddom.tech:6443 --token 1eytpq.yj317xna5nl4a594 --discovery-token-ca-cert-hash sha256:83eef2dac5d014d563c236f632c2aecef61533bcd197c759ea28caea1eef5382
```

<ins>ERREUR:</ins> 
error execution phase preflight: couldn't validate the identity of the API Server: could not find a JWS signature in the cluster-info ConfigMap for token ID "0d1dt4"
To see the stack trace of this error execute with --v=5 or higher

<ins>QUOI FAIRE ? :</ins>
```yaml
This error message suggests that there was a problem validating the identity of the API Server when executing the preflight phase of a Kubernetes operation. 
Specifically, it states that a JWS signature could not be found in the cluster-info ConfigMap for the token ID "0d1dt4".
A JWS (JSON Web Signature) is a compact, URL-safe means of representing signed content using JSON data structures. In this context, 
it is likely that the API Server is using JWS signatures to validate the authenticity of the token ID, but the necessary signature could not be found in the cluster-info ConfigMap.
To troubleshoot this issue, you can try executing the failing operation with the --v=5 or higher flag to see a more detailed stack trace of the error. 
This may provide additional context that can help identify the root cause of the problem.
Another potential solution is to check that the cluster-info ConfigMap is properly configured and contains the necessary JWS signatures. 
You can use the kubectl get cm cluster-info -n kube-public -o yaml command to view the contents of the cluster-info ConfigMap.
If the problem persists, it may be helpful to seek assistance from the Kubernetes community or consult the Kubernetes documentation for more 
information on troubleshooting JWS signature validation issues.
```
