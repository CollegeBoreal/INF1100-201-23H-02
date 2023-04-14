# :ab: Maghreb :brain:

| Server           | Hostname                             |  IP               | Specs                 |
|------------------|--------------------------------------|-------------------|-----------------------|
| data plane    |    hakimdrai@blida.maghreb.hafsa.tech | `10.13.237.33/24` | 64GB Ram,      16cpus |
| data plane       |    chaks@algeria.maghreb.hafsa.tech  | `10.13.237.37/24` | 64GB Ram,      16cpus |
| data plane       |    memedlebleu@rak.maghreb.hafsa.tech  | `10.13.237.26/24` | 64GB Ram,       8cpus |
| control plane       |    hafsa@maroc.maghreb.hafsa.tech   | `10.13.237.17/24` | 64GB Ram,      16cpus |


```
kubeadm join betelgeuse.orion.gasy.africa:6443 --token ks2wis.b6dcthm6zf7zp25w \
    --discovery-token-ca-cert-hash sha256:0a61dd16cad49b9439c7aaeeb63139e88aa9d0a78918158d9d73634e1585a723
```

| objet                                            | Description                                             |
|--------------------------------------------------|---------------------------------------------------------|
| `kubeadm join`                                   | Commande permettant d'ajouter un noeud à la grappe      |
| betelgeuse.orion.gasy.africa:6443                | :x: nom et port du serveur où se trouve le plan de contrôle | 
| `--token` ks2wis.b6dcthm6zf7zp25w                | Paramètre se référant au jeton                          |
| `--discovery-token-ca-cert-hash` sha256:0a61dd16 | Paramètre se référant au certificat permettant à la bonne identification du jeton  |
