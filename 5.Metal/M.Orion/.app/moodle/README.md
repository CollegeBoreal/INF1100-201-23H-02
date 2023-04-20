# Moodle


```
bash create-moodle.sh
```
> Returns :
```yaml
coalesce.go:199: warning: destination for customRules is a table. Ignoring non-table value []
NAME: moodle
LAST DEPLOYED: Sun Apr 16 11:01:21 2023
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: moodle
CHART VERSION: 14.3.14
APP VERSION: 4.1.2** Please be patient while the chart is being deployed **

1. Get the Moodle&trade; URL:

  echo "Moodle&trade; URL: http://127.0.0.1:8080/"
  kubectl port-forward --namespace default svc/moodle 8080:80

2. Get your Moodle&trade; login credentials by running:

  echo Username: admin
  echo Password: $(kubectl get secret --namespace default moodle -o jsonpath="{.data.moodle-password}" | base64 -d)
```

```
bash drop-moodle.sh 
```
> Returns :
```yaml
release "moodle" uninstalled
persistentvolumeclaim "data-moodle-mariadb-0" deleted
```

## :x: Troubleshooting

```
k describe pod moodle-7d7d9fb64-ttsm5
```
> Returns :
```yaml
Name:             moodle-7d7d9fb64-ttsm5
Namespace:        default
Priority:         0
Service Account:  default
Node:             nunki/192.168.1.108
Start Time:       Sun, 16 Apr 2023 11:01:23 -0400
Labels:           app.kubernetes.io/instance=moodle
                  app.kubernetes.io/managed-by=Helm
                  app.kubernetes.io/name=moodle
                  helm.sh/chart=moodle-14.3.14
                  pod-template-hash=7d7d9fb64
Annotations:      prometheus.io/port: 9117
                  prometheus.io/scrape: true
Status:           Pending
IP:               
IPs:              <none>
Controlled By:    ReplicaSet/moodle-7d7d9fb64
Containers:
  moodle:
    Container ID:   
    Image:          docker.io/bitnami/moodle:3.11.11-debian-11-r16
    Image ID:       
    Ports:          8080/TCP, 8443/TCP
    Host Ports:     0/TCP, 0/TCP
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Requests:
      cpu:      300m
      memory:   512Mi
    Liveness:   http-get http://:http/login/index.php delay=600s timeout=5s period=10s #success=1 #failure=6
    Readiness:  http-get http://:http/login/index.php delay=30s timeout=3s period=5s #success=1 #failure=6
    Environment:
      BITNAMI_DEBUG:                false
      ALLOW_EMPTY_PASSWORD:         yes
      APACHE_HTTP_PORT_NUMBER:      8080
      APACHE_HTTPS_PORT_NUMBER:     8443
      MOODLE_DATABASE_TYPE:         mariadb
      MOODLE_DATABASE_HOST:         moodle-mariadb
      MOODLE_DATABASE_PORT_NUMBER:  3306
      MOODLE_DATABASE_NAME:         bitnami_moodle
      MOODLE_DATABASE_USER:         bn_moodle
      MOODLE_DATABASE_PASSWORD:     <set to the key 'mariadb-password' in secret 'moodle-mariadb'>  Optional: false
      MOODLE_SKIP_BOOTSTRAP:        no
      MOODLE_USERNAME:              admin
      MOODLE_PASSWORD:              <set to the key 'moodle-password' in secret 'moodle'>  Optional: false
      MOODLE_SITE_NAME:             moodle.gasy.africa
      MOODLE_EMAIL:                 setrar@gasy.africa
    Mounts:
      /bitnami/moodle from moodle-data (rw,path="moodle")
      /bitnami/moodledata from moodle-data (rw,path="moodledata")
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-wfvjc (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             False 
  ContainersReady   False 
  PodScheduled      True 
Volumes:
  moodle-data:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  moodle-moodle
    ReadOnly:   false
  kube-api-access-wfvjc:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   Burstable
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason            Age                  From               Message
  ----     ------            ----                 ----               -------
  Warning  FailedScheduling  3m38s                default-scheduler  0/2 nodes are available: pod has unbound immediate PersistentVolumeClaims. preemption: 0/2 nodes are available: 2 No preemption victims found for incoming pod..
  Normal   Scheduled         3m37s                default-scheduler  Successfully assigned default/moodle-7d7d9fb64-ttsm5 to nunki
  Warning  FailedMount       93s                  kubelet            Unable to attach or mount volumes: unmounted volumes=[moodle-data], unattached volumes=[], failed to process volumes=[]: timed out waiting for the condition
  Warning  FailedMount       72s (x8 over 3m26s)  kubelet            MountVolume.MountDevice failed for volume "pvc-686e9e58-8eb3-4978-8083-bbcf1c568501" : rpc error: code = Internal desc = Waiting for pvc-686e9e58-8eb3-4978-8083-bbcf1c568501's CVC to be bound
```

```
k describe pod moodle-mariadb-0      
```
> Returns :
```yaml
Name:             moodle-mariadb-0
Namespace:        default
Priority:         0
Service Account:  moodle-mariadb
Node:             nunki/192.168.1.108
Start Time:       Sun, 16 Apr 2023 11:01:23 -0400
Labels:           app.kubernetes.io/component=primary
                  app.kubernetes.io/instance=moodle
                  app.kubernetes.io/managed-by=Helm
                  app.kubernetes.io/name=mariadb
                  controller-revision-hash=moodle-mariadb-54d9bc855f
                  helm.sh/chart=mariadb-11.5.5
                  statefulset.kubernetes.io/pod-name=moodle-mariadb-0
Annotations:      checksum/configuration: 85771f42c53e06c5ab36d24abfcbc8c039befc557cbdc15fcfbe86f7e05bba89
Status:           Pending
IP:               
IPs:              <none>
Controlled By:    StatefulSet/moodle-mariadb
Containers:
  mariadb:
    Container ID:   
    Image:          docker.io/bitnami/mariadb:10.6.12-debian-11-r13
    Image ID:       
    Port:           3306/TCP
    Host Port:      0/TCP
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Liveness:       exec [/bin/bash -ec password_aux="${MARIADB_ROOT_PASSWORD:-}"
if [[ -f "${MARIADB_ROOT_PASSWORD_FILE:-}" ]]; then
    password_aux=$(cat "$MARIADB_ROOT_PASSWORD_FILE")
fi
mysqladmin status -uroot -p"${password_aux}"
] delay=120s timeout=1s period=10s #success=1 #failure=3
    Readiness:  exec [/bin/bash -ec password_aux="${MARIADB_ROOT_PASSWORD:-}"
if [[ -f "${MARIADB_ROOT_PASSWORD_FILE:-}" ]]; then
    password_aux=$(cat "$MARIADB_ROOT_PASSWORD_FILE")
fi
mysqladmin status -uroot -p"${password_aux}"
] delay=30s timeout=1s period=10s #success=1 #failure=3
    Environment:
      BITNAMI_DEBUG:          false
      MARIADB_ROOT_PASSWORD:  <set to the key 'mariadb-root-password' in secret 'moodle-mariadb'>  Optional: false
      MARIADB_USER:           bn_moodle
      MARIADB_PASSWORD:       <set to the key 'mariadb-password' in secret 'moodle-mariadb'>  Optional: false
      MARIADB_DATABASE:       bitnami_moodle
    Mounts:
      /bitnami/mariadb from data (rw)
      /opt/bitnami/mariadb/conf/my.cnf from config (rw,path="my.cnf")
Conditions:
  Type              Status
  Initialized       True 
  Ready             False 
  ContainersReady   False 
  PodScheduled      True 
Volumes:
  data:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  data-moodle-mariadb-0
    ReadOnly:   false
  config:
    Type:        ConfigMap (a volume populated by a ConfigMap)
    Name:        moodle-mariadb
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                 node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason            Age                 From               Message
  ----     ------            ----                ----               -------
  Warning  FailedScheduling  4m16s               default-scheduler  0/2 nodes are available: pod has unbound immediate PersistentVolumeClaims. preemption: 0/2 nodes are available: 2 No preemption victims found for incoming pod..
  Normal   Scheduled         4m15s               default-scheduler  Successfully assigned default/moodle-mariadb-0 to nunki
  Warning  FailedMount       2m12s               kubelet            Unable to attach or mount volumes: unmounted volumes=[data], unattached volumes=[], failed to process volumes=[]: timed out waiting for the condition
  Warning  FailedMount       36s (x9 over 4m5s)  kubelet            MountVolume.MountDevice failed for volume "pvc-5238ff0c-7746-4724-bbc0-320d3ee8b998" : rpc error: code = Internal desc = Waiting for pvc-5238ff0c-7746-4724-bbc0-320d3ee8b998's CVC to be bound
```

# References


