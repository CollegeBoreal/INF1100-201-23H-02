# :cl: Piano :musical_keyboard:

 https://fr.wikipedia.org/wiki/Piano

| Server           | Hostname                             |  IP               | Specs                 |
|------------------|--------------------------------------|-------------------|-----------------------|
| control plane    | klyd@do.piano.klyddom.tech | `10.13.237.16/24` | 64GB Ram,      16cpus |
| data plane       | frank_uranus@re.piano.klyddom.tech | `10.13.237.34/24` | 64GB Ram,      16cpus |
| data plane       | ziko@mi.piano.klyddom.tech | `10.13.237.39/24` | 64GB Ram,       8cpus |
| data plane       | sedric_g@fa.piano.klyddom.tech | `10.13.237.36/24` | 64GB Ram,      16cpus |

Token pour joindre le control plane (pour les worker nodes): 
kubeadm join do.piano.klyddom.tech:6443 --token 1eytpq.yj317xna5nl4a594 --discovery-token-ca-cert-hash sha256:83eef2dac5d014d563c236f632c2aecef61533bcd197c759ea28caea1eef5382

Erreur a corriger: error execution phase preflight: couldn't validate the identity of the API Server: could not find a JWS signature in the cluster-info ConfigMap for token ID "0d1dt4"
To see the stack trace of this error execute with --v=5 or higher

kubeadm join do.piano.klyddom.tech:6443 --token 1eytpq.yj317xna5nl4a594 --discovery-token-ca-cert-hash sha256:83eef2dac5d014d563c236f632c2aecef61533bcd197c759ea28caea1eef5382

